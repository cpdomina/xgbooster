#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
XGBOOST_DIR="$CURRENT_DIR/xgboost"
JVM_DIR="$XGBOOST_DIR/jvm-packages"
LIB_DIR="$XGBOOST_DIR/lib"

# checkout repo && apply patch
if [ ! -d "$XGBOOST_DIR" ]; then
    git clone --recursive https://github.com/dmlc/xgboost "$XGBOOST_DIR"
    cd $XGBOOST_DIR
    git checkout 1b77903eeb55d8c27fc94fe8ae1d7526c69bed0d -b xgboost-static
    git apply "$CURRENT_DIR/xgboost-patch.diff"
fi

# clear from previous runs
cd $XGBOOST_DIR
make clean
cd $CURRENT_DIR
rm -rf libxgboost4j.so

# start docker-machine
echo $(docker-machine create --driver virtualbox default)
echo $(docker-machine start default)
eval $(docker-machine env default)

# create lib with centos6
docker build -t linux-docker-img linux-docker-img
docker run -v $(pwd):/builder linux-docker-img /bin/bash -c "export CC=/opt/rh/devtoolset-4/root/usr/bin/gcc; export CXX=/opt/rh/devtoolset-4/root/usr/bin/c++; export JAVA_HOME=/usr/lib/jvm/java; cd /builder/xgboost/jvm-packages; python ./create_jni.py"

mv $LIB_DIR/libxgboost4j.so . 

# clear from previous run
cd $XGBOOST_DIR
make clean

# create lib with mac
cd $JVM_DIR
python create_jni.py

# create jar with both libs
mv $CURRENT_DIR/libxgboost4j.so $LIB_DIR
mvn package -pl :xgboost4j

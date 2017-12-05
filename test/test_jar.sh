#!/usr/bin/env bash
set -xe

# Clean the yum cache
yum -y clean all
yum -y clean expire-cache

# Install all the needed packages.
yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm

yum -y install java-1.8.0-openjdk-devel

export JAVA_HOME=/usr/lib/jvm/java

cd /test
javac -cp dependencies/*:xgboost4j-0.7.jar:. xg.java
java -cp dependencies/*:xgboost4j-0.7.jar:. xg

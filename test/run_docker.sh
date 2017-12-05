#!/usr/bin/env bash

echo $(docker-machine create --driver virtualbox default)
echo $(docker-machine start default)
eval $(docker-machine env default)

docker run -v `pwd`:/test:rw centos:centos6 /bin/bash -c "bash -xe /test/test_jar.sh";

FROM centos:6

RUN set -xe

# Clean the yum cache
RUN yum -y clean all
RUN yum -y clean expire-cache

# Install all the needed packages.
RUN yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm
RUN yum -y install wget tar cmake3 zlib-devel python34 java-1.8.0-openjdk-devel

# Setup SCL for newer GCC.
RUN yum -y install centos-release-scl-rh
RUN yum -y install devtoolset-4-{gcc,gcc-c++}

RUN source /opt/rh/devtoolset-4/enable

# CMake3 is not aliased to ``cmake``
RUN ln -s /usr/bin/cmake3 /usr/bin/cmake
RUN rm /usr/bin/python
RUN ln -s /usr/bin/python3 /usr/bin/python

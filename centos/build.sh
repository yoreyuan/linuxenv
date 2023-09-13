#!/usr/bin/env bash
set -e

#docker build -f Dockerfile-0 -t linuxenv-v0:centos7.9.2009 .
#docker build -f Dockerfile-0 -t linuxenv-v1:centos7.9.2009 .
docker build -f Dockerfile -t linuxenv:centos7.9.2009 .

#!/usr/bin/env bash
set -e

# 指定为 KDE
#docker build . -f Dockerfile -t linuxenv-kde:centos7.9.2009 --build-arg "DESKTOP_TYPE=KDE"

# 指定为 GNOME
#docker build . -f Dockerfile -t linuxenv-gnome:centos7.9.2009 --build-arg "DESKTOP_TYPE=GNOME"

# 指定为 Xfce
#docker build . -f Dockerfile -t linuxenv-xfce:centos7.9.2009 --build-arg "DESKTOP_TYPE=Xfce"

# 默认为 GNOME
docker build . -f Dockerfile -t linuxenv:centos7.9.2009

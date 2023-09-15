#!/usr/bin/env bash
set -e

# 指定为 GNOME
#docker build . -f Dockerfile -t linuxenv-gnome:latest --build-arg "DESKTOP_TYPE=GNOME"

# 指定为 Xfce
#docker build . -f Dockerfile -t linuxenv-xfce:latest --build-arg "DESKTOP_TYPE=Xfce"
# 同时安装开启docker
#docker build . -f Dockerfile -t linuxenv-xfce:latest --build-arg "DESKTOP_TYPE=Xfce" --build-arg "INSTALL_DOCKER=true"

# 默认为 GNOME
docker build -f Dockerfile -t linuxenv:latest .

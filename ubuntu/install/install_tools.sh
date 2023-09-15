#!/usr/bin/env bash
set -e

export DEBIAN_FRONTEND=$DEBIAN_FRONTEND
echo "====== DEBIAN_FRONTEND=$DEBIAN_FRONTEND"

#echo "alias ll='ls -l'  2>/dev/null" >> /etc/profile.d/colorgrep.sh

echo "Install some common tools for further installation"

#apt-get upgrade
# Update tzdata noninteractive (otherwise our script is hung on user input later).
DEBIAN_FRONTEND=noninteractive TZ=$TZ apt-get -y install tzdata
apt-get install -y bzip2 wmctrl software-properties-common mesa-utils bc

#update mesa to latest
#add-apt-repository ppa:kisak/turtle
#apt-get update
#apt full-upgrade -y

apt-get -y  --fix-missing --no-install-recommends install \
  apache2 \
  bridge-utils \
  ca-certificates \
  dnsutils \
  curl \
  dos2unix \
  gnupg \
  inetutils-ping \
  jq \
  language-pack-zh-hans \
  language-pack-zh-hans-base \
  less \
  locales \
  lrzsz \
  lsof \
  mtr \
  mysql-client \
  nano \
  net-tools \
  procps \
  python3 \
  software-properties-common \
  sudo \
  tcpdump \
  telnet \
  traceroute \
  tree \
  tini \
  tzdata \
  vim \
  wget \
  zip unzip

systemctl disable apache2


#echo "generate locales for en_US.UTF-8"
#locale-gen en_US.UTF-8
echo "zh_CN.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen zh_CN.UTF-8
echo "export LANG=zh_CN.UTF-8" >> $HOME/.bashrc

update-alternatives --install /usr/bin/python python /usr/bin/python3 1
ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone


apt-get update
apt-get install -y xdotool
apt-get install -y vlc git tmux


### docker
if [ "true" = "$INSTALL_DOCKER" ]; then
  curl -fsSL https://get.docker.com -o get-docker.sh
  mv get-docker.sh $INST_SCRIPTS/get-docker.sh
  sh $INST_SCRIPTS/get-docker.sh
  systemctl enable docker
fi


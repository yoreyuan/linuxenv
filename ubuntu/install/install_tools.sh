#!/usr/bin/env bash
set -e

export DEBIAN_FRONTEND=$DEBIAN_FRONTEND
echo "====== DEBIAN_FRONTEND=$DEBIAN_FRONTEND"

echo "Install some common tools for further installation"
if [[ "${DISTRO}" == @(centos|oracle7) ]] ; then
  yum install -y vim wget net-tools bzip2 python3 ca-certificates bc
elif [[ "${DISTRO}" == @(fedora37|fedora38|oracle8|oracle9|rockylinux9|rockylinux8|almalinux8|almalinux9) ]]; then
  dnf install -y wget net-tools bzip2 python3 tar vim hostname procps-ng bc
elif [ "${DISTRO}" == "opensuse" ]; then
  sed -i 's/download.opensuse.org/mirrorcache-us.opensuse.org/g' /etc/zypp/repos.d/*.repo
  zypper install -yn wget net-tools bzip2 python3 tar vim gzip iputils bc
elif [ "${DISTRO}" == "alpine" ]; then
  apk add --no-cache \
    ca-certificates \
    curl \
    gcompat \
    grep \
    libgcc \
    mcookie \
    net-tools \
    openssh-client \
    openssl \
    shadow \
    sudo \
    tar \
    wget \
    bc
else
  apt-get update
  # Update tzdata noninteractive (otherwise our script is hung on user input later).
  DEBIAN_FRONTEND=noninteractive TZ=$TZ apt-get -y install tzdata
  apt-get install -y vim wget net-tools locales bzip2 wmctrl software-properties-common mesa-utils bc

  echo "generate locales for en_US.UTF-8"
  locale-gen en_US.UTF-8
fi

if [ "$DISTRO" = "ubuntu" ]; then
  #update mesa to latest
  #add-apt-repository ppa:kisak/turtle
  #apt-get update
  #apt full-upgrade -y

  apt-get -y --no-install-recommends install \
    language-pack-zh-hans \
    language-pack-zh-hans-base \
    gnupg \
    ca-certificates \
    software-properties-common \
    locales \
    curl \
    tzdata \
    less \
    python3 \
    vim \
    procps \
    net-tools \
    inetutils-ping \
    wget \
    bridge-utils \
    traceroute \
    mtr \
    dnsutils \
    nano \
    lsof \
    telnet \
    tcpdump \
    lrzsz \
    dos2unix \
    zip \
    unzip \
    tree \
    mysql-client \
    tini \
    jq \
    apache2 \
    sudo

  systemctl disable apache2

  echo "zh_CN.UTF-8 UTF-8" >> /etc/locale.gen
  locale-gen zh_CN.UTF-8
  echo "export LANG=zh_CN.UTF-8" >> $HOME/.bashrc
  update-alternatives --install /usr/bin/python python /usr/bin/python3 1
  ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

fi


if [ "$DISTRO" = centos ]; then
  yum install -y nano zip wget
  yum install epel-release -y
  yum install xdotool -y
else
  apt-get update
  apt-get install -y nano zip xdotool
  apt-get install -y vlc git tmux
fi

#!/usr/bin/env bash
set -e

if [[ "${DISTRO}" == @(centos|oracle7) ]] ; then
  echo 123456 | passwd --stdin
fi

if [ "$DISTRO" = "ubuntu" ]; then
  apt-get install -y openssh-server

  sed -i 's/#PermitRootLogin .*/PermitRootLogin yes/' /etc/ssh/sshd_config

  #取消pam限制
  sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

  echo root:123456 | chpasswd
fi

#tightvncserver
apt-get install -y xrdp

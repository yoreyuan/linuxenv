#!/usr/bin/env bash
set -e

# Distro package cleanup
if [[ "${DISTRO}" == @(centos|oracle7) ]] ; then
  yum clean all
elif [[ "${DISTRO}" == @(almalinux8|almalinux9|fedora37|fedora38|oracle8|oracle9|rockylinux8|rockylinux9) ]]; then
  dnf clean all
elif [ "${DISTRO}" == "opensuse" ]; then
  zypper clean --all
elif [[ "${DISTRO}" == @(debian|kali|parrotos5|ubuntu) ]]; then
  apt-get autoremove -y
  apt-get autoclean -y
fi


rm -rf /var/lib/apt/lists/* /var/tmp/*
rm -rf /dockerstartup/images


# Remove xfce4-screensaver bin if it exists
if which xfce4-screensaver; then
  rm -f $(which xfce4-screensaver)
fi


#!/usr/bin/env bash
set -e


##################################
# install RDP
#tightvncserver
apt-get install -y xrdp

#默认端口为3389，配置文件为：/etc/xrdp/xrdp.ini

#if [ "Xfce" == "$DESKTOP_TYPE" ]; then
#  echo "xfce4-session" > $HOME/.Xclients
#  chmod +x $HOME/.Xclients
#  sed -i "s/ssl_protocols=/; ssl_protocols=/g" /etc/xrdp/xrdp.ini
#  #sed -i "58i ssl_protocols=TLSv1, TLSv1.3, TLSv1.1, TLSv1.2, TLSv3" /etc/xrdp/xrdp.ini
#  sed -i "59i ssl_protocols=TLSv1, TLSv1.1, TLSv1.2" /etc/xrdp/xrdp.ini
#fi


##################################

### GNOME桌面
if [ "GNOME" == "$DESKTOP_TYPE" ]; then
  apt-get install -y ubuntu-desktop
fi


### Install xfce UI
if [ "Xfce" == "$DESKTOP_TYPE" ]; then
  bash $INST_SCRIPTS/install_xfce_ui.sh
  mv $INST_SCRIPTS/xfce/.config $HOME/

  mkdir -p /usr/share/extra/backgrounds/
  mkdir -p /usr/share/extra/icons/

  mv /dockerstartup/images/bg_default.png /usr/share/extra/backgrounds/bg_default.png
  cp /dockerstartup/images/icon_ubuntu.png /usr/share/extra/icons/icon_ubuntu.png
  mv /dockerstartup/images/icon_ubuntu.png /usr/share/extra/icons/icon_default.png

fi

FROM ubuntu:latest

MAINTAINER YoreYuen

#ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'
ENV LANG='zh_CN.UTF-8' LANGUAGE='zh_CN:zh' LC_ALL='zh_CN.utf8'
ENV TZ=Asia/Shanghai
ENV JAVA_HOME=/usr/lib/jvm/zulu17
ENV NOTVISIBLE "in users profile"
ENV INST_SCRIPTS=/tmp/install
ENV HOME=/root
ENV DISTRO=ubuntu

ARG DEBIAN_FRONTEND=noninteractive

### Home setup
WORKDIR $HOME
RUN mkdir -p $HOME/Desktop

ADD ./common /dockerstartup
ADD ./install $INST_SCRIPTS
#如果下载比较慢，可以将下面两个包提前下载到当前目录下
COPY ./idea-2023.2.1.tar ./chrome.deb /tmp/

RUN set -xeu && \
    echo 'Acquire::Retries "3";' > /etc/apt/apt.conf.d/80-retries && \
    echo 'Acquire::http::Timeout "15";' > /etc/apt/apt.conf.d/80-timeouts && \
    sed -i "s@http://.*archive.ubuntu.com@http://repo.huaweicloud.com@g" /etc/apt/sources.list && \
    sed -i "s@http://.*security.ubuntu.com@http://repo.huaweicloud.com@g" /etc/apt/sources.list && \
    apt-get -qq update

### Install common tools
RUN DEBIAN_FRONTEND=$DEBIAN_FRONTEND bash $INST_SCRIPTS/install_tools.sh

### Install openssh server
RUN bash $INST_SCRIPTS/install_sshd.sh

### Install JDK
RUN bash $INST_SCRIPTS/install_jdk.sh

### Install custom fonts
RUN bash $INST_SCRIPTS/install_custom_fonts.sh

### Install xfce UI
RUN bash $INST_SCRIPTS/install_xfce_ui.sh
#ADD ./xfce/.config/ /root/.config/
RUN mkdir -p /usr/share/extra/backgrounds/
RUN mkdir -p /usr/share/extra/icons/
ADD ./common/images/bg_default.png /usr/share/extra/backgrounds/bg_default.png
ADD ./common/images/icon_ubuntu.png /usr/share/extra/icons/icon_ubuntu.png
ADD ./common/images/icon_ubuntu.png /usr/share/extra/icons/icon_default.png

### Custom Folder Emblems
RUN bash $INST_SCRIPTS/install_emblems.sh

### Install Chrome
RUN bash $INST_SCRIPTS/install_chrome.sh

### Install Sublime Text
RUN bash $INST_SCRIPTS/install_sublime_text.sh

### Install IDEA
RUN bash $INST_SCRIPTS/install_idea.sh

### Cleanup job
RUN bash $INST_SCRIPTS/install_clean.sh && rm -rf $INST_SCRIPTS


EXPOSE 22
EXPOSE 3389
ENTRYPOINT ["/usr/sbin/init"]

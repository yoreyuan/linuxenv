FROM ubuntu:latest

MAINTAINER YoreYuen

#ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'
ENV LANG='zh_CN.UTF-8' LANGUAGE='zh_CN:zh' LC_ALL='zh_CN.utf8'
ENV TZ=Asia/Shanghai
ENV NOTVISIBLE "in users profile"
ENV INST_SCRIPTS=/tmp/install
ENV HOME=/root
ENV DISTRO=ubuntu

ARG DEBIAN_FRONTEND=noninteractive

### Home setup
WORKDIR $HOME
RUN mkdir -p $HOME/Desktop

RUN set -xeu && \
    echo 'Acquire::Retries "3";' > /etc/apt/apt.conf.d/80-retries && \
    echo 'Acquire::http::Timeout "15";' > /etc/apt/apt.conf.d/80-timeouts && \
    sed -i "s@http://.*archive.ubuntu.com@http://repo.huaweicloud.com@g" /etc/apt/sources.list && \
    sed -i "s@http://.*security.ubuntu.com@http://repo.huaweicloud.com@g" /etc/apt/sources.list && \
    apt-get -qq update

ADD ./common /dockerstartup

### Install common tools
COPY ./install/install_tools.sh $INST_SCRIPTS/install_tools.sh
RUN DEBIAN_FRONTEND=$DEBIAN_FRONTEND bash $INST_SCRIPTS/install_tools.sh

### Install openssh server
COPY ./install/install_sshd.sh $INST_SCRIPTS/install_sshd.sh
RUN bash $INST_SCRIPTS/install_sshd.sh

### Install JDK
COPY ./install/install_jdk.sh $INST_SCRIPTS/install_jdk.sh
RUN bash $INST_SCRIPTS/install_jdk.sh

### Install custom fonts
COPY ./install/install_custom_fonts.sh $INST_SCRIPTS/install_custom_fonts.sh
RUN bash $INST_SCRIPTS/install_custom_fonts.sh

### Install xfce UI
COPY ./install/install_xfce_ui.sh $INST_SCRIPTS/install_xfce_ui.sh
RUN bash $INST_SCRIPTS/install_xfce_ui.sh
#ADD ./xfce/.config/ /root/.config/
RUN mkdir -p /usr/share/extra/backgrounds/
RUN mkdir -p /usr/share/extra/icons/
ADD ./common/images/bg_default.png /usr/share/extra/backgrounds/bg_default.png
ADD ./common/images/icon_ubuntu.png /usr/share/extra/icons/icon_ubuntu.png
ADD ./common/images/icon_ubuntu.png /usr/share/extra/icons/icon_default.png

### Custom Folder Emblems
COPY ./install/install_emblems.sh $INST_SCRIPTS/install_emblems.sh
RUN bash $INST_SCRIPTS/install_emblems.sh

### Install Chrome
COPY ./install/install_chrome.sh $INST_SCRIPTS/install_chrome.sh
RUN bash $INST_SCRIPTS/install_chrome.sh

### Install Sublime Text
COPY ./install/install_sublime_text.sh $INST_SCRIPTS/install_sublime_text.sh
RUN bash $INST_SCRIPTS/install_sublime_text.sh

### Cleanup job
COPY ./install/install_clean.sh $INST_SCRIPTS/install_clean.sh
RUN bash $INST_SCRIPTS/install_clean.sh && rm -rf $INST_SCRIPTS/install_clean.sh

ENV JAVA_HOME=/usr/lib/jvm/zulu17

EXPOSE 22
EXPOSE 3389
ENTRYPOINT ["/usr/sbin/init"]

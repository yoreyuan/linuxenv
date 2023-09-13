#FROM centos:latest
#FROM image.cestc.cn/wh-bigdata/trino-base:centos8-jdk17
FROM centos:centos7.9.2009

MAINTAINER YoreYuen

ENV HOME=/root
ENV INST_SCRIPTS=/tmp/install
#ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'
ENV LANG='zh_CN.UTF-8' LANGUAGE='zh_CN:zh' LC_ALL='zh_CN.utf8'
ENV TZ=Asia/Shanghai
ENV JAVA_HOME=/usr/lib/jvm/zulu17


ARG DEBIAN_FRONTEND=noninteractive
ARG START_XFCE4=1
ARG DESKTOP_TYPE=GNOME
#ARG DESKTOP_TYPE=KDE
#ARG DESKTOP_TYPE=Xfce

ADD ./install $INST_SCRIPTS
#如果下载比较慢，可以将下面两个包提前下载到当前目录下
COPY ./idea-2023.2.1.tar ./chrome.rpm /tmp/

WORKDIR $HOME
RUN mkdir -p $HOME/Desktop

# 华为镜像源
#RUN set -xeu && \
#    mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.bak && \
#    #wget -O /etc/yum.repos.d/CentOS-Base.repo https://repo.huaweicloud.com/repository/conf/CentOS-7-reg.repo && \
#    mv $INST_SCRIPTS/CentOS-7-reg.repo /etc/yum.repos.d/CentOS-Base.repo && \
#    chmod 644  /etc/yum.repos.d/CentOS-Base.repo && \
#    yum install -y epel-release && \
#    yum clean all && yum -y -q update && yum makecache

# 清华镜像源
RUN set -xeu && \
    sed -e 's|^mirrorlist=|#mirrorlist=|g' \
    -e 's|^#baseurl=http://mirror.centos.org/centos|baseurl=https://mirrors.tuna.tsinghua.edu.cn/centos|g' \
    -i.bak \
    /etc/yum.repos.d/CentOS-*.repo && \
    yum install -y epel-release && \
    yum clean all && yum -y -q update && yum makecache

### Ensure all needed packages are installed.
### Consider "yum install -y gettext nss_wraper". There's a typo in nss_wraper
### (should be nss_wrapper), and yum would just ignore it. Thus, a necessary
### package would be missing. With skip_missing_names_on_install, yum will exit
### with 1 exit code and that will stop image building.
RUN yum-config-manager --setopt=skip_missing_names_on_install=False --save

### Install Desktop
RUN DEBIAN_FRONTEND=$DEBIAN_FRONTEND bash $INST_SCRIPTS/install_desktop.sh

### Install openssh server
RUN bash $INST_SCRIPTS/install_sshd.sh

### Install common tools
RUN  bash $INST_SCRIPTS/install_tools.sh

### Install JDK
RUN bash $INST_SCRIPTS/install_jdk.sh

### Install Chrome
RUN bash $INST_SCRIPTS/install_chrome.sh

### Install IDEA
RUN bash $INST_SCRIPTS/install_idea.sh

### Sublime Text
RUN bash $INST_SCRIPTS/install_sublime_text.sh

## Cleanup job
RUN bash $INST_SCRIPTS/centos-setup.sh
RUN bash $INST_SCRIPTS/centos-cleanup.sh && rm -rf $INST_SCRIPTS


EXPOSE 22
EXPOSE 3389
ENTRYPOINT ["/usr/sbin/init"]

FROM ubuntu:latest

MAINTAINER YoreYuen

#ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'
ENV LANG='zh_CN.UTF-8' LANGUAGE='zh_CN:zh' LC_ALL='zh_CN.utf8'
ENV TZ=Asia/Shanghai
ENV NOTVISIBLE "in users profile"
ARG DEBIAN_FRONTEND=noninteractive

WORKDIR /root/
#COPY sources.list /etc/apt/sources.list

RUN set -xeu && \
    echo 'Acquire::Retries "3";' > /etc/apt/apt.conf.d/80-retries && \
    echo 'Acquire::http::Timeout "15";' > /etc/apt/apt.conf.d/80-timeouts && \
    sed -i "s@http://.*archive.ubuntu.com@http://repo.huaweicloud.com@g" /etc/apt/sources.list && \
    sed -i "s@http://.*security.ubuntu.com@http://repo.huaweicloud.com@g" /etc/apt/sources.list && \
    apt-get -qq update


#tools
RUN set -xeu && \
    apt-get -y --no-install-recommends install language-pack-zh-hans language-pack-zh-hans-base \
            gnupg ca-certificates software-properties-common locales curl tzdata \
            less python3 vim \
            procps net-tools inetutils-ping \
            wget bridge-utils traceroute mtr dnsutils nano lsof telnet \
            tcpdump lrzsz dos2unix zip unzip tree mysql-client tini jq apache2 sudo && \
    echo "zh_CN.UTF-8 UTF-8" >> /etc/locale.gen && \
    locale-gen zh_CN.UTF-8 && \
    update-alternatives --install /usr/bin/python python /usr/bin/python3 1 && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone


# zulu jdk
RUN set -xeu && \
    curl -s https://repos.azul.com/azul-repo.key | gpg --dearmor -o /usr/share/keyrings/azul.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/azul.gpg] https://repos.azul.com/zulu/deb stable main" | tee /etc/apt/sources.list.d/zulu.list && \
    echo "Package: zulu17-*\nPin: version 17.0.8-*\nPin-Priority: 1001" > /etc/apt/preferences && \
    apt-get -qq update && \
    # zulu17-jdk=17.0.8-*
    apt-get -y --no-install-recommends install zulu17-jdk && \
    apt-get -qq -y purge --auto-remove software-properties-common && \
    # maven 3.x
    wget https://repo.huaweicloud.com/apache/maven/maven-3/3.9.2/binaries/apache-maven-3.9.2-bin.tar.gz && \
    tar -zxf apache-maven-3.9.2-bin.tar.gz && mv apache-maven-3.9.2 /usr/local/maven && \
    ln -s /usr/local/maven/bin/mvn /usr/local/bin/mvn && \
    mkdir /root/.m2 && \
    rm -rf apache-maven-3.9.2-bin.tar.gz


# desktop
RUN set -xeu && \
    #apt-get -qq -y install openssh-server xrdp ubuntu-desktop && \
    apt-get install -y openssh-server ubuntu-desktop unity compizconfig-settings-manager xrdp && \
    sed -i 's/#PermitRootLogin .*/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    #取消pam限制
    sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd && \
    #echo 123456 | passwd --stdin && \
    echo root:123456 | chpasswd && \
    echo "export VISIBLE=now" >> /etc/profile && \
    rm -rf /var/lib/apt/lists/*


ENV JAVA_HOME=/usr/lib/jvm/zulu17

COPY --chown=root:root bin/init.sh /etc/rc2.d/S02myinit

EXPOSE 22
EXPOSE 3389
ENTRYPOINT ["/usr/sbin/init"]

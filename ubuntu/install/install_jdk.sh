#!/usr/bin/env bash
set -e

echo "Install Zulu jdk"
curl -s https://repos.azul.com/azul-repo.key | gpg --dearmor -o /usr/share/keyrings/azul.gpg
echo "deb [signed-by=/usr/share/keyrings/azul.gpg] https://repos.azul.com/zulu/deb stable main" | tee /etc/apt/sources.list.d/zulu.list
echo "Package: zulu17-*\nPin: version 17.0.8-*\nPin-Priority: 1001" > /etc/apt/preferences

apt-get -qq update

# zulu17-jdk=17.0.8-*
apt-get -y --no-install-recommends install zulu17-jdk
apt-get -qq -y purge --auto-remove software-properties-common

# maven 3.x
#echo "Install Maven 3.9"
#wget https://repo.huaweicloud.com/apache/maven/maven-3/3.9.2/binaries/apache-maven-3.9.2-bin.tar.gz
#tar -zxf apache-maven-3.9.2-bin.tar.gz && mv apache-maven-3.9.2 /usr/local/maven
#ln -s /usr/local/maven/bin/mvn /usr/local/bin/mvn
#mkdir $HOME/.m2
#rm -rf apache-maven-3.9.2-bin.tar.gz

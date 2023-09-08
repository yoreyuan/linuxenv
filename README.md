一个Linux的Java开发环境
==================

# Overview
Docker + RDP + 远程桌面连接方式，可以在Windows系统下使用Linux环境作为自己的开发环境。

目前提供如下操作系统环境：
* Ubuntu 22.04.3

开发环境中提供如下
* JDK 17
* Python 3
* RDP


# Quickstart
进入到支持的系统的目录下，构建镜像，例如进入到 `ubuntu`。执行如下命令:
```bash
cd ubuntu/
docker build -f Dockerfile -t linuxenv:latest .
```

启动容器
```bash
docker-compose -f docker-compose.yaml up -d
#docker exec -i -u root linuxenv apt-get -qq update
```

通过ssh访问容器
```bash
#  password: 123456
ssh -p 3022 root@127.0.0.1
```

在Windows下按`Windows + R`，并输入`mstsc`以打开**远程桌面连接**，在结算机输入框中输入： `127.0.0.1:3388`,
用户名root对应的默认密码为123456。成功进入后可以看到熟悉的Ubuntu桌面。
如果卡住或者黑屏、闪退，可以到用户的家目录下查看 `~/.xorgxrdp.10.log`、`~/.xsession-errors`文件信息，来定位及解决。


# Features
* 镜像以Docker的方式提供，意味着只要支持Docker的系统，都可以快速部署此环境；
* Linux系统以比较常用的Ubuntu官方镜像为基础镜像进行构建；
* 镜像提供了Ubuntu Desktop可视化桌面；
* 支持通过ssh和远程桌面方式访问系统;
* 非常适合Windows系统下，需要使用Linux开发的同学。对于不支持Windows（或支持不太好的）的项目不必为了在Windows系统中运行项目而修改大量代码。
通过Docker volume可以在两个系统直接随意切换。


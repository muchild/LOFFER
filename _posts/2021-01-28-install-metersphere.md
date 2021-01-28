---
layout: post
title: 安装启动MeterSphere测试平台
date: 2021-01-28 02:40:54
author: 七禾叶
tags: [test]
comments: true
toc: true
pinned: false
---


> 在testerhome上看到开源测试平台MeterSphere，感觉蛮好的就想安装一把。。顺道推荐给我领导。。
> 哎，自己的安装过程真的是心塞。。各种不仔细引发的安装不成功。。

### 一、介绍吧

> 官网文档地址：[MeterSphere](https://metersphere.io/docs/)
> 其他就直接看官网吧，很直观了，我用的离线安装的方式

### 二、修改配置

> 1、如果/opt目录下还没有生成metershpere文件夹(也就是还没有/bin/sh install.sh)，这样直接修改好/metersphere-release-v1.7.0-rc1/install.conf就好
> 
> 本人使用的是外部mysql和外部kafka，配置如下
> ![image.png](https://i.loli.net/2021/01/28/kRemgQ4SD5UVoMb.png)
> 再按照官网说的/bin/sh install.sh 就好
> 访问地址：http://your_ip:8081


> 2、如果/opt目录下已经有生成metershpere文件夹
> 
> 那就需要修改/opt/metersphere/.env文件了。。
> 配置如上图，或者把/opt/metersphere整个删除后，修改了install.conf后，直接/bin/sh install.sh也行(**离线升级，貌似也可以这样操作,配置文件记得保持一致**)

> 3、如果是阿里云服务器，记得安全组规格把端口访问权限打开

> 4、kafka安装时都需要注意的
> 
> 因为MeterSphere是装在docker里的，所以外部kafka需要配置外部访问方式
> 配置如下：
> ![image.png](https://i.loli.net/2021/01/28/YQA72EczSes9Tdi.png)

> 5、一直操作
> 
> 修改配置文件后，记得msctl reload，然后msctl restart一下

> 6、关于log
> 
> tail -f /opt/metersphere/logs/metersphere/info.log 看服务是否正常启动了
> docker ps 查询到 ms-data-streaming 的容器Id，sudo docker attach 容器Id，看下kafka是否正常连接了

### 三、发发牢骚吧

> 还是得仔细点。。
> 之前没发现kafka的配置不对，没连接上，导致发现安装MeterSphere后，服务器的cpu使用率直线飙升到90%
> 还跑到meterSphere维护群里去怼了他们。。哎。。
>
> 还有就是自己kafka的端口号写错了。。没发现，直接搞到2点才发现。。几个小时时间就这么过去了。。
>
> 以后还是仔细点吧。。。

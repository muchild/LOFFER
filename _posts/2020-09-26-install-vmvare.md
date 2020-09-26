---
layout: post
title: 安装VMware
date: 2020-09-26 15:15:33
author: 七禾叶
tags: [linux]
comments: true
toc: false
pinned: false
---

> 不记得啥时候报的课程了，突然来兴趣要学一学，既然如此就得先从环境开始，需要安装linux虚拟机
> 做个记录吧，反正也无聊

### 一、下载VMware
> 本来我是打算去下载破解版的。。结果官网有个人免费版，那就下这个吧
> 注册&&下载地址：https://my.vmware.com/group/vmware/evalcenter?p=fusion-player-personal
> 
### 二、安装VMware
> 安装完打开VMware且配置了虚拟机后，启动虚拟机提示：请确保已载入内核模块 'vmmon'
> 百度了下，说安全与隐私下打开：**任何来源**(sudo spctl --master-disable)就好。。可是我都打开了呀为啥还是不行。。
> 这个时候就要说了，所有文章都说只要打开任何设置，可是他们没说还得**重启VMware**啊。。搞我半天，晕倒了

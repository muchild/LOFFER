---
layout: post
title: windows powershell 取出间隔行数据
date: 2020-05-13 19:55:01
author: 七禾叶
tags: [windows]
comments: true
toc: false
pinned: false
---


> 找了份工作用的是windows电脑，也没linux。。诶，各种不顺手。。很多windows 10专业版的功能还都不能用


>![CDt1vPl9xFzfO5E](https://i.loli.net/2020/05/13/CDt1vPl9xFzfO5E.png)
>
>```markdown
> 获取3之前的所有行(从1开始计数)：get-content log.txt | where {$_.readcount -lt 3}
> 获取3之后的所有行(从1开始计数)：get-content log.txt | where {$_.readcount -gt 3}
> 获取被4整数的行数(从1开始计数)：get-content log.txt | where {$_.readcount% 4 -eq 0}
> 获取index为(2,4)之间的数(从0开始计数)：Get-Content log.txt | Select-Object -Index (2..4)
> ```
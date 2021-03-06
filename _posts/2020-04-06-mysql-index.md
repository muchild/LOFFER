---
layout: post
title: 从0到1掌握MySQL的索引系统
date: 2020-04-06
author: 七禾叶
tags: [面试]
comments: true
toc: false
pinned: false
---


> 放这个[链接地址](https://ke.qq.com/course/465858#term_id=101749681)不是为了广告，只是当时面试真的遇到不少MySQL的问题，看了视频的确了解多了一些。总得说明出处。。
>
> 面试还是要多多准备吧。。最后的最后，我去了外包公司又干起了功能测试。。

#### 1、索引是帮助MySQL高效获取数据的数据结构

> **MySQL为什么选择B+树作为索引数据结构?**
>
> Hive: key+文件+偏移量，本身是离线返回数据
>
> 当数据量非常大的时候，如果采用Hive的数据结构的话，会导致数据量无限大。
>
> **MySQL是事务数据库，需要及时返回数据，实时性要求高**

#### 2、索引存储在文件系统中

> 存放在内存中，宕机后，数据会消失。
>
> **存放在文件系统中，可实现持久化，重新开机后，数据会重新加载，会设计到IO问题**
>
> ​	1、减少IO量
>
> ​	2、减少IO次数

#### 3、索引的文件存储形式与存储引擎有关

> 存储引擎：不同数据文件在磁盘上的组织形式
>
> **innodb：**
>
> ​	·frm：表结构
>
> ​	.ibd：Innodb储存引擎的数据文件和索引文件，数据文件和索引文件放一起
>
> **myisam:**
>
> ​	·frm：表结构
>
> ​	.MYD：数据文件
>
> ​	.MYI：索引文件
>
> 存储引擎不同，直接导致对应的索引文件系统不一样

#### 4、索引文件的结构(数据结构)

> A、hash
>
> B、二叉树
>
> C、B树
>
> D、B+树

> **hash索引：**
>
> ​	不支持范围查询
>
> ​	需要全表扫描
>
> ​	不适合排序操作
>
> **B+树索引：**
>
> ​	支持范围查询、等值查询

#### 5、聚簇索引与非聚簇索引的区别

> **聚簇索引：**数据和索引是绑定在一起，拿到key就可以得到整条数据，没有指定主键，没有非空唯一key的话，就使用6位的rowId
>
> **非聚簇索引：**叶子节点放的是地址，根据地址再次查找数据

#### 6、innodb、myisam的区别

> **innodb：**支持行锁、支持事务、支持外键、索引结构不同
>
> **myisam：**支持表锁，不支持事务、不支持外键、索引结构不同

> **辅助索引：**叶子节点存储主键信息

> **执行计划：**

> **联合索引-最左匹配：**在包含多个列的查询过程中，会依靠先查第一个列，再查第二个列，比如添加具体地址需要先选省份才能选择市区

#### 7、索引下推、回表、MRR、MVCC

> **使用索引下推：**根据name，age两个字断把满足要求的数据拉取到server层，在server层取出对应的数据
>
> **不使用索引下推：**根据name列的值把所有的数据拉取到server层，在server层对age过滤

> **回表：**先根据普通索引查询到主键值，根据主键值去主键索引拉去需要的整行数据
>
> **MRR：**多范围读取
>
> **MVCC：**多版本并发控制









​	
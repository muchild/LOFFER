---
layout: post
title: MySQL 快速创建百万级测试数据
date: 2020-05-05 10:04:51
author: 七禾叶
tags: [MySQL]
comments: true
toc: false
pinned: false
---

> 这文章是早些时候写的了，因为把简书账号删了，文章也需要清空，这边再记录洗吧。。


## 方法1 编写存储过程和函数执行
#### 一、建表
```Mysql
CREATE TABLE `t_user_info` (
  `id` bigint(20) NOT NULL COMMENT '全局Id',
  `email` varchar(30) NOT NULL DEFAULT '' COMMENT '用户邮箱地址',
  `phone` varchar(11) DEFAULT NULL COMMENT '手机号',
  `name` varchar(10) NOT NULL DEFAULT '' COMMENT '用户姓名',
  `nick_name` varchar(20) DEFAULT NULL COMMENT '用户昵称',
  `age` int(11) NOT NULL COMMENT '用户年纪',
  `password` varchar(20) NOT NULL COMMENT '登录密码',
  `open_id` varchar(200) DEFAULT NULL COMMENT '微信open_id',
  `logo` varchar(50) DEFAULT NULL COMMENT '用户头像url',
  `sex` tinyint(2) NOT NULL DEFAULT '0' COMMENT '用户性别 0:男 1:女',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '用户状态 0:失效 1:有效',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`id`),
  KEY `t_user_info_id_index` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户信息'
```

```MySQL
Create Table: CREATE TABLE `t_user_info_memory` (
  `id` bigint(20) NOT NULL COMMENT '全局Id',
  `email` varchar(30) NOT NULL DEFAULT '' COMMENT '用户邮箱地址',
  `phone` varchar(11) DEFAULT NULL,
  `name` varchar(10) NOT NULL DEFAULT '' COMMENT '用户姓名',
  `nick_name` varchar(20) DEFAULT NULL COMMENT '用户昵称',
  `age` int(11) NOT NULL COMMENT '用户年纪',
  `password` varchar(20) NOT NULL,
  `open_id` varchar(200) DEFAULT NULL COMMENT '微信open_id',
  `logo` varchar(50) DEFAULT NULL COMMENT '用户头像url',
  `sex` tinyint(2) NOT NULL DEFAULT '0' COMMENT '用户性别 0:男 1:女',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '用户状态 0:失效 1:有效',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8mb4
```

#### 二、创建函数和存储过程
```MySQL
// 创建随机字符串
create
    definer = root@`%` function randStr(n int) returns varchar(255)
begin
    declare char_str varchar(100) default 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    declare return_str varchar(255) default ''; declare i int default 0;
    while i < n
        do
            set return_str = concat(return_str, substring(char_str, floor(1 + rand() * 10), 1)); set i = i + 1;
        end while;
    return return_str;
end;

```

```MySQL
// 创建插入数据存储过程
create
    definer = root@`%` procedure add_t_user_memory(IN n bigint)
begin
    declare i int default 1;
    while(i <= n)
        do
            insert into t_user_info_memory(id, name, nick_name, sex, age, logo, email, open_id, status,phone,password)
            values (uuid_short(), randStr(7), randStr(7), 1, 33, null, 'jane1229@163.com', null, 1,'12345678901','123123');
            set i = i + 1;
        end while;
end;

```

#### 三、调用存储过程
```
CALL add_t_user_memory(1000000); // 花费5分钟
```

>
> 期间的报错信息如下：
> **ERROR 1114 (HY000): The table 't_user_info_memory' is full**
> 
> 解决办法：
> 1、set max_heap_table_size=64*1024*1024;
> 2、set tmp_table_size=67108864;
> 3、ALTER TABLE t_user_info_memory MAX_ROWS=1000000000;
>

#### 四、从内存表插入普通表
```
INSERT INTO t_user SELECT * FROM t_user_memory; // 花费8秒
```

>期间报错信息如下：
>**ERROR 2006 (HY000): MySQL server has gone away**
>解决办法：
>set global max_allowed_packet=1024*1024*1024;



PS：https://juejin.im/post/5ce372c36fb9a07ef63fb191
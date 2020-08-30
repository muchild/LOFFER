---
layout: post
title: jwt初次学习
date: 2020-08-30 13:18:10
author: 七禾叶
tags: [jwt]
comments: true
toc: false
pinned: false
---

> 延续上一篇文章内容，还在学习jwt，做了个小demo

### 一、jwt概念
> Json web token (JWT), 是为了在网络应用环境间传递声明而执行的一种基于JSON的开放标准（(RFC 7519).该token被设计为紧凑且安全的，特别适用于分布式站点的单点登录（SSO）场景。JWT的声明一般被用来在身份提供者和服务提供者间传递被认证的用户身份信息，以便于从资源服务器获取资源，也可以增加一些额外的其它业务逻辑所必须的声明信息，该token也可直接被用于认证，也可被加密。

### 二、jwt构成

> 第一部分我们称它为头部（header),第二部分我们称其为载荷（payload, 类似于飞机上承载的物品)，第三部分是签证（signature).

### 三、例子
> ```xml
> <dependency>
>    <groupId>com.auth0</groupId>
>    <artifactId>java-jwt</artifactId>
>    <version>3.9.0</version>
> </dependency>
> ```
>
> ```java
> package com.jane.demo.jwt.util;
> 
> import org.springframework.beans.factory.annotation.Value;
> import org.springframework.stereotype.Component;
> 
> import java.time.LocalDate;
> import java.time.LocalDateTime;
> import java.time.ZoneId;
> import java.time.ZonedDateTime;
> import java.util.Date;
> 
> /**
>  * @author jane
>  * created on 2020/8/29
>  */
> 
> @Component
> public class DateUtil {
>     @Value("${jwt_expire}")
>     private int jwt_expire;
> 
>     /**
>      * 过期时间
>      */
>     public Date getExpiredDate() {
>         LocalDate localDate = LocalDate.now();
>         LocalDate localDateTomorrow = localDate.plusDays(jwt_expire);
>         ZonedDateTime zonedDateTime = localDateTomorrow.atStartOfDay(ZoneId.systemDefault());
>         return Date.from(zonedDateTime.toInstant());
>     }
> 
>     /**
>      * 获取随意数字
>      */
>     public Long getRandomNumber() {
>         LocalDateTime localDateTime = LocalDateTime.now();
>         LocalDateTime localDateTimeAfter = localDateTime.plusSeconds(3);
>         ZonedDateTime zonedDateTime = localDateTimeAfter.atZone(ZoneId.systemDefault());
>         return Date.from(zonedDateTime.toInstant()).getTime();
>     }
> }
> 
> ```
>
> ```java
> package com.jane.demo.jwt.util;
> 
> import com.auth0.jwt.JWT;
> import com.auth0.jwt.JWTVerifier;
> import com.auth0.jwt.algorithms.Algorithm;
> import com.auth0.jwt.exceptions.JWTDecodeException;
> import com.auth0.jwt.exceptions.SignatureVerificationException;
> import com.auth0.jwt.exceptions.TokenExpiredException;
> import com.auth0.jwt.interfaces.Claim;
> import com.auth0.jwt.interfaces.DecodedJWT;
> import lombok.extern.slf4j.Slf4j;
> import org.apache.commons.lang3.StringUtils;
> import org.springframework.beans.factory.annotation.Autowired;
> import org.springframework.beans.factory.annotation.Value;
> import org.springframework.stereotype.Component;
> 
> import java.util.HashMap;
> import java.util.Map;
> 
> /**
>  * @author jane
>  * created on 2020/8/29
>  */
> @Slf4j
> @Component
> public class JwtUtil {
>     @Value("${jwt_secret}")
>     private String jwt_secret;
> 
>     @Autowired
>     private DateUtil dateUtil;
> 
>     /**
>      * 生成token
>      */
>     public String jwtGenerator() {
>         Map<String, Object> map = new HashMap<>();
>         map.put("random", dateUtil.getRandomNumber());
> 
>         Algorithm algorithm = Algorithm.HMAC256(jwt_secret);
>         return JWT.create().withHeader(map)
>                 .withClaim("username", "jane")
>                 .withClaim("userId", "100780091")
>                 .withClaim("nickname", "七禾叶")
>                 .withClaim("random", dateUtil.getRandomNumber())
>                 .withExpiresAt(dateUtil.getExpiredDate())
>                 .sign(algorithm);
>     }
> 
>     /**
>      * 解密Token
>      */
>     public Map<String, Claim> verifyToken(String token) {
>         DecodedJWT jwt = null;
>         try {
>             JWTVerifier verifier = JWT.require(Algorithm.HMAC256(jwt_secret)).build();
>             jwt = verifier.verify(token);
>             return jwt.getClaims();
>         } catch (JWTDecodeException | SignatureVerificationException | IllegalArgumentException | TokenExpiredException | NullPointerException e) {
>             throw new RuntimeException("校验失败, 抛出Token验证非法异常", e);
>         }
>     }
> 
>     /**
>      * 根据Token获取userId
>      */
>     public String getSecretInfo(String token) {
>         try {
>             Map<String, Claim> claims = verifyToken(token);
>             if (claims == null) {
>                 throw new RuntimeException("token无效 {}");
>             }
>             Claim claim = claims.get("userId");
>             if (StringUtils.isBlank(claim.asString())) {
>                 throw new RuntimeException("未接收到userId");
>             }
>             return claim.asString();
>         } catch (NullPointerException e) {
>             throw new RuntimeException("getUserInfo error", e);
>         }
>     }
> }
> ```
>
> 运行结果：
>
> ![1.png](https://i.loli.net/2020/08/30/iVqhoMABlwxcefS.png)
>
> ![2.png](https://i.loli.net/2020/08/30/wb7mHpoRTS4GLYr.png)
>
> ![获取到userId.png](https://i.loli.net/2020/08/30/eqPQv15Vj2N7ROM.png)



---
layout: post
title: 学习 Spring AOP
date: 2020-08-23 12:56:29
author: 七禾叶
tags: [java]
comments: true
toc: false
pinned: false
---

> 从去年被裁到现在就没学习过。。昨天老同学说你学习下jwt吧。。然后百度了下，发现资料太多了。。最后找到了2019年08月买的一个课程里有介绍jwt就看起来了，顺道学习了下spring aop，好事吧。。

### 一、AOP 概述
> AOP 即 Aspect Oriented Program 面向切面编程;分散在各个业务逻辑代码中相同的代码通过横向切割的方式抽取到一个独立的模块中！
>
> 目的：AOP能够将那些与业务无关，却为业务模块所共同调用的逻辑或责任（例如事务处理、日志管理、权限控制等）封装起来，便于减少系统的重复代码，降低模块间的耦合度，并有利于未来的可拓展性和可维护性。

### 二、AOP 当中的概念：
> 切入点（Pointcut）
> 
> 在哪些类，哪些方法上切入（where）；可以简单得认为：使用@Aspect 注解得类就是切面
> 
> 通知（Advice）
> 
> 在方法执行的什么实际（when:方法前/方法后/方法前后）做什么（what:增强的功能）
> 
> 切面（Aspect）
> 
> 切面 = 切入点 + 通知，通俗点就是：在什么时机，什么地方，做什么增强！
> 
> 织入（Weaving）
>
> 把切面加入到对象，并创建出代理对象的过程。（由 Spring 来完成）

### 三、Spring AOP 原理
> Spring AOP的底层原理就是动态代理

### 四、使用注解来开发 Spring AOP
> 第一步：选择连接点
>
> **选择哪一个类的哪一方法用以增强功能**
> 
> ``` java
> @Service
> public class UserServiceImpl implements IUserservice {
>    @Override
>    public void getWork() {
>        System.out.println("拿到了offer");
>    }
> }
> ```
>
> 第二步：创建切面
> 
>```java
> @Component
> @Aspect
> @Slf4j
> public class Work{
>     @Before("execution(* com.example.demo.service.impl.UserServiceImpl.getWork())")
>     public void before(){
>         System.out.println("进行了面试");
>     }
> 
>     @After("execution(* com.example.demo.service.impl.UserServiceImpl.getWork())")
>     public void after(){
>          System.out.println("准备入职");
>     }
> }
>```
>
> 第三步：定义切点
>
> ```java
> @Component
> @Aspect
> @Slf4j
> public class Work{
>     @Pointcut("execution(* com.example.demo.service.impl.UserServiceImpl.getWork())")
>     public void getWorkPointCut(){
> 
>     }
> 
>     @Before("getWorkPointCut()")
>     public void before(){
>         System.out.println("进行了面试");
>     }
> 
>     @After("getWorkPointCut()")
>     public void after(){
>         System.out.println("准备入职");
>     }
> }
> ```
>
> 第四步：测试 AOP
>
> ![1.png](https://i.loli.net/2020/08/23/TIbzEYFPqr6XVgH.png)
>

### 五、@Before、@After、@Around 执行顺序
> ```java
> package com.example.demo.aspect;
>   
>   import lombok.extern.slf4j.Slf4j;
>   import org.aspectj.lang.JoinPoint;
>   import org.aspectj.lang.ProceedingJoinPoint;
>   import org.aspectj.lang.annotation.*;
>   import org.springframework.stereotype.Component;
>   
>   @Component
>   @Aspect
>   @Slf4j
>   public class Work{
>       public static boolean flag = true;
> 
>       @Pointcut("execution(* com.example.demo.service.impl.UserServiceImpl.getWork())")
>       public void getWorkPointCut(){
>       }
>   
>       @Before("getWorkPointCut()")
>       public void before(JoinPoint joinPoint){
>           System.err.println("before " + joinPoint);
>       }
>   
>       @After("getWorkPointCut()")
>       public void after(JoinPoint joinPoint){
>           System.err.println("after " + joinPoint);
>       }
>   
>       @Around("getWorkPointCut()")
>       private void work(ProceedingJoinPoint joinPoint) throws Throwable {
>           System.err.println("in around before " + joinPoint);
>           if (flag) {
>               joinPoint.proceed();
>           }
>           System.err.println("in around after " + joinPoint);
>       }
>   }
>```
> 
> **结果：**
> 
> in around before execution(void com.example.demo.service.impl.UserServiceImpl.getWork())
> 
> before execution(void com.example.demo.service.impl.UserServiceImpl.getWork())
> 
> in hello
> 
> after execution(void com.example.demo.service.impl.UserServiceImpl.getWork())
> 
> in around after execution(void com.example.demo.service.impl.UserServiceImpl.getWork())
> 
> in around before execution(void com.example.demo.service.impl.UserServiceImpl.getWork())
> 
> in around after execution(void com.example.demo.service.impl.UserServiceImpl.getWork())
>
> 结论：proceed()没有被调用时，不调用before/after

> 相关文章：
> https://www.jianshu.com/p/994027425b44
> https://stackoverflow.com/questions/18016503/aspectj-around-and-proceed-with-before-after
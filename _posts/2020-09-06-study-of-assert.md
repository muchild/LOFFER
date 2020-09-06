---
layout: post
title: 关于断言的使用
date: 2020-09-06 13:14:44
author: 七禾叶
tags: [spring]
comments: true
toc: false
pinned: false
---

> 周五的时候看了开发写的测试代码，不需要判断直接断言，而我写的先判断后断言再过多余了。。

### 一、java assert

> 断言是使用Java中的 `assert` 语句实现的。 在执行断言时，它被认为是正确的。 如果失败，JVM会抛出一个名为 `AssertionError` 的错误。 它主要用于开发过程中的测试目的。
>
> #### 1、表达式：
>
> ```java
> assert expression;
> assert expression : errorMessage;
> ```
>
> #### 2、列子：
>
> ```java
> public class Test {
>     public static void main(String[] args) {
>         int a = 10;
>         assert a >= 20;
>         System.out.println("a = " + a);
>     }
> }
> ```
>
> > 运行结果：
> >
> > ```java
> > a = 10 // Java在执行程序的时候默认是不启动断言检查
> > ```
> >
> > 在idea运行是配置jvm参数：-ea，再次运行结果：
> >
> > ```java
> > Exception in thread "main" java.lang.AssertionError
> > 	at Test.main(Test.java:8)
> > ```
> >
> > **jvm一般线上都不会开启断言，如果在发布程序的时候，该句会被忽视**
>
>
>
> 参考文章：
>
> [Java断言，一个被遗忘的关键字！](http://www.justdojava.com/2019/07/09/java-assert/)
>
> [JAVA的断言 - Assert](https://juejin.im/post/6844904037335171085)

### 二、spring assert的作用

> #### 1、表达式
>
> ```markdown
> 1 对象和类型断言
> 	notNull(Object object, String message)：入参一定不是 null；
> 	isNull(Object object, String message)：入参一定是 null；
> 	isInstanceOf(Class type, Object obj, String message):检查对象必须为另一个特定类型的实例
> 	isAssignable(Class superType, Class subType, String message)：subType 必须可以按类型	匹配于 superType
> 2 文本断言
> 	通常用来检查字符串参数。
> 	hasLength(String text, String message)：当 text 为 null 或长度为 0 时抛出异常,空格算长度为1；
> 	hasText(String text, String message)：text 不能为 null 且必须至少包含一个非空格的字符，否则抛出异常；
> 	两者都区别：
> 	hasLength(String text)文本为空格时不会抛出异常，但是hasText(String text)在空格的时候会抛出异常。
> 
> 3 集合断言
> 	notEmpty(Collection collection, String message)：当集合未包含元素时抛出异常。
> ```
>
> #### 2、统一异常处理
>
> Spring在3.2版本增加了一个注解@ControllerAdvice，可以与@ExceptionHandler、@InitBinder、@ModelAttribute 等注解注解配套使用
>
> > **四个注解作用：**
> >
> > @ControllerAdvice: 一个特殊的`@Component`，用于标识一个类
> >
> > @ExceptionHandler: 统一异常处理，也可以指定要处理的异常类型
> >
> > @InitBinder: 注册属性编辑器，对HTTP请求参数进行处理，再绑定到对应的接口，比如格式化的时间转换等。应用于单个@Controller类的方法上时，仅对该类里的接口有效。与@ControllerAdvice组合使用可全局生效
> >
> > @ModelAttribute: 绑定数据
>
> #### 3、例子：
>
> > ```java
> > // AdviceController.java
> > 
> > import com.jane.demo.jwt.common.BaseRuntimeException;
> > import com.jane.demo.jwt.controller.vo.Answer;
> > import lombok.extern.slf4j.Slf4j;
> > import org.apache.catalina.connector.ClientAbortException;
> > import org.apache.commons.lang3.StringUtils;
> > import org.springframework.validation.BindException;
> > import org.springframework.validation.BindingResult;
> > import org.springframework.validation.FieldError;
> > import org.springframework.validation.ObjectError;
> > import org.springframework.web.bind.MethodArgumentNotValidException;
> > import org.springframework.web.bind.annotation.ControllerAdvice;
> > import org.springframework.web.bind.annotation.ExceptionHandler;
> > import org.springframework.web.bind.annotation.ResponseBody;
> > 
> > import java.util.ArrayList;
> > import java.util.List;
> > 
> > @ControllerAdvice
> > @Slf4j
> > public class AdviceController extends AbstractController {
> >     /**
> >      * 全局异常捕捉处理
> >      *
> >      * @param ex
> >      * @return
> >      */
> >     @ResponseBody
> >     @ExceptionHandler(value = {MethodArgumentNotValidException.class, BindException.class})
> >     public Answer<?> errorValidHandler(MethodArgumentNotValidException ex) {
> >         log.error("controller error!", ex);
> >         BindingResult bindingResult = ex.getBindingResult();
> >         if (bindingResult.hasErrors()) {
> >             List<String> errorMsgList = new ArrayList<>();
> >             for (ObjectError error : bindingResult.getAllErrors()) {
> >                 String fieldName = StringUtils.EMPTY;
> >                 if (error instanceof FieldError) {
> >                     fieldName = ((FieldError) error).getField();
> >                 }
> >                 errorMsgList.add(String.format("%s", error.getDefaultMessage()));
> >             }
> >             return super.renderError(StringUtils.join(errorMsgList, ","));
> >         }
> > 
> >         return super.renderError("接口异常: " + ex.getMessage());
> >     }
> > 
> >     /**
> >      * 全局异常捕捉处理
> >      *
> >      * @param ex
> >      * @return
> >      */
> >     @ResponseBody
> >     @ExceptionHandler(value = Exception.class)
> >     public Answer<?> errorHandler(Exception ex) {
> >         log.error("controller error!", ex);
> >         return super.renderError("接口异常: " + ex.getMessage());
> >     }
> > 
> >     @ResponseBody
> >     @ExceptionHandler(value = ClientAbortException.class)
> >     public Answer<?> errorClientAbort(Exception ex) {
> >         log.error("controller error!", ex);
> >         return super.renderError("接口异常 {}" + ex.getMessage());
> >     }
> > 
> >     @ResponseBody
> >     @ExceptionHandler(value = BaseRuntimeException.class)
> >     public Answer<?> errorBasesHandler(Exception ex) {
> >         log.error("service error!", ex);
> >         return super.renderError(ex.getMessage());
> >     }
> > }
> > ```
> >
> > ```java
> > // AbstractController.java
> > 
> > import com.jane.demo.jwt.controller.vo.Answer;
> > 
> > import javax.servlet.http.HttpServletRequest;
> > import java.util.Enumeration;
> > import java.util.HashMap;
> > 
> > public abstract class AbstractController {
> > 
> >     public HashMap<String, String> parseRequestParameter(HttpServletRequest request) {
> >         HashMap<String, String> ret = new HashMap<>();
> >         Enumeration<String> names = request.getParameterNames();
> >         while (names.hasMoreElements()) {
> >             String name = names.nextElement();
> >             ret.put(name, request.getParameter(name));
> >         }
> > 
> >         return ret;
> >     }
> > 
> >     public <T> Answer<T> renderError(Integer code, String msg) {
> >         Answer<T> answer = new Answer<>();
> >         answer.setCode(code);
> >         answer.setMsg(msg);
> >         return answer;
> >     }
> > 
> >     public <T> Answer<T> renderError(String msg) {
> >         Answer<T> answer = new Answer<>();
> >         answer.setCode(1);
> >         answer.setMsg(msg);
> >         return answer;
> >     }
> > 
> >     public <T> Answer<T> renderAnswer(T result) {
> >         Answer<T> answer = new Answer<>();
> >         answer.setCode(0);
> >         answer.setMsg("操作完成");
> >         answer.setResult(result);
> >         return answer;
> >     }
> > 
> >     public <T> Answer<T> renderDefaultAnswer() {
> >         Answer<T> answer = new Answer<>();
> >         answer.setCode(0);
> >         answer.setMsg("操作完成");
> >         return answer;
> >     }
> > 
> >     public <T> Answer<T> renderOK() {
> >         Answer<T> answer = new Answer<>();
> >         answer.setCode(0);
> >         answer.setMsg("操作完成");
> >         answer.setResult((T) "OK");
> >         return answer;
> >     }
> > }
> > ```
> >
> > ```java
> > // Answer.java
> > 
> > package com.jane.demo.jwt.controller.vo;
> > 
> > import lombok.Data;
> > import org.codehaus.jackson.map.annotate.JsonSerialize;
> > 
> > @JsonSerialize(include = JsonSerialize.Inclusion.NON_NULL)
> > @Data
> > public class Answer<T> {
> >     private Integer code;
> >     private String msg;
> >     private T result;
> > 
> >     public Answer() {
> >         code = 0;
> >     }
> > 
> >     @SuppressWarnings("rawtypes")
> >     public static Answer<?> newBuilder() {
> >         return new Answer();
> >     }
> > 
> >     public Answer<T> setCodeAndMsg(Integer code, String msg) {
> >         this.code = code;
> >         this.msg = msg;
> >         return this;
> >     }
> > }
> > ```
> >
> > ```java
> > // BaseRuntimeException.java
> > 
> > public class BaseRuntimeException extends RuntimeException {
> >     public BaseRuntimeException() {
> >     }
> > 
> >     public BaseRuntimeException(String message) {
> >         super(message);
> >     }
> > 
> >     public BaseRuntimeException(String message, Throwable cause) {
> >         super(message, cause);
> >     }
> > 
> >     public BaseRuntimeException(Throwable cause) {
> >         super(cause);
> >     }
> > 
> >     public BaseRuntimeException(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {
> >         super(message, cause, enableSuppression, writableStackTrace);
> >     }
> > }
> > ```
> >
> > ```java
> > //使用assert前调用方法：
> > 
> > package com.jane.demo.jwt.util;
> > 
> > import com.auth0.jwt.JWT;
> > import com.auth0.jwt.JWTVerifier;
> > import com.auth0.jwt.algorithms.Algorithm;
> > import com.auth0.jwt.exceptions.JWTDecodeException;
> > import com.auth0.jwt.exceptions.SignatureVerificationException;
> > import com.auth0.jwt.exceptions.TokenExpiredException;
> > import com.auth0.jwt.interfaces.Claim;
> > import com.auth0.jwt.interfaces.DecodedJWT;
> > import com.jane.demo.jwt.common.BaseRuntimeException;
> > import lombok.extern.slf4j.Slf4j;
> > import org.apache.commons.lang3.StringUtils;
> > import org.springframework.beans.factory.annotation.Autowired;
> > import org.springframework.beans.factory.annotation.Value;
> > import org.springframework.stereotype.Component;
> > 
> > import java.util.HashMap;
> > import java.util.Map;
> > 
> > /**
> >  * @author guoying
> >  * created on 2020/8/29
> >  */
> > @Slf4j
> > @Component
> > public class JwtUtil {
> >     @Value("${jwt_secret}")
> >     private String jwt_secret;
> > 
> >     @Autowired
> >     private DateUtil dateUtil;
> > 
> >     /**
> >      * 生成token
> >      */
> >     public String jwtGenerator() {
> >         Map<String, Object> map = new HashMap<>();
> >         map.put("random", dateUtil.getRandomNumber());
> > 
> >         Algorithm algorithm = Algorithm.HMAC256(jwt_secret);
> >         return JWT.create().withHeader(map)
> >                 .withClaim("username", "jane")
> >                 .withClaim("userId", "1000780091")
> >                 .withClaim("nickname", "七禾叶")
> >                 .withClaim("random", dateUtil.getRandomNumber())
> >                 .withExpiresAt(dateUtil.getExpiredDate())
> >                 .sign(algorithm);
> >     }
> > 
> >     /**
> >      * 解密Token
> >      */
> >     public Map<String, Claim> verifyToken(String token) {
> >         DecodedJWT jwt = null;
> >         try {
> >             JWTVerifier verifier = JWT.require(Algorithm.HMAC256(jwt_secret)).build();
> >             jwt = verifier.verify(token);
> >             return jwt.getClaims();
> >         } catch (JWTDecodeException | SignatureVerificationException | IllegalArgumentException | TokenExpiredException | NullPointerException e) {
> >             throw new BaseRuntimeException("校验失败, 抛出Token验证非法异常", e);
> >         }
> >     }
> > 
> >     /**
> >      * 根据Token获取userId
> >      */
> >     public String getSecretInfo(String token) {
> >         try {
> >             Map<String, Claim> claims = verifyToken(token);
> >             if (claims == null){
> >                 throw new BaseRuntimeException("token校验失败");
> >             }
> >             Claim claim = claims.get("userId");
> >             if (StringUtils.isBlank(claim.asString())) {
> >                 throw new BaseRuntimeException("未接收到userId");
> >             }
> >             return claim.asString();
> >         } catch (NullPointerException e) {
> >             throw new BaseRuntimeException("获取用户信息失败", e);
> >         }
> >     }
> > }
> > 
> > ```
> > 调用结果：
> > ```json
> > 
> > {
> >   "code": 1,
> >   "msg": "获取用户信息失败",
> >   "result": null
> > }
> > ```
> >
> > ```java
> > //使用assert后调用方法：
> > 
> > import com.auth0.jwt.JWT;
> > import com.auth0.jwt.JWTVerifier;
> > import com.auth0.jwt.algorithms.Algorithm;
> > import com.auth0.jwt.exceptions.JWTDecodeException;
> > import com.auth0.jwt.exceptions.SignatureVerificationException;
> > import com.auth0.jwt.exceptions.TokenExpiredException;
> > import com.auth0.jwt.interfaces.Claim;
> > import com.auth0.jwt.interfaces.DecodedJWT;
> > import com.jane.demo.jwt.common.BaseRuntimeException;
> > import lombok.extern.slf4j.Slf4j;
> > import org.springframework.beans.factory.annotation.Autowired;
> > import org.springframework.beans.factory.annotation.Value;
> > import org.springframework.stereotype.Component;
> > import org.springframework.util.Assert;
> > 
> > import java.util.HashMap;
> > import java.util.Map;
> > 
> > /**
> >  * @author guoying
> >  * created on 2020/8/29
> >  */
> > @Slf4j
> > @Component
> > public class JwtUtil {
> >     @Value("${jwt_secret}")
> >     private String jwt_secret;
> > 
> >     @Autowired
> >     private DateUtil dateUtil;
> > 
> >     /**
> >      * 生成token
> >      */
> >     public String jwtGenerator() {
> >         Map<String, Object> map = new HashMap<>();
> >         map.put("random", dateUtil.getRandomNumber());
> > 
> >         Algorithm algorithm = Algorithm.HMAC256(jwt_secret);
> >         return JWT.create().withHeader(map)
> >                 .withClaim("username", "jane")
> >                 .withClaim("userId", "1000780091")
> >                 .withClaim("nickname", "七禾叶")
> >                 .withClaim("random", dateUtil.getRandomNumber())
> >                 .withExpiresAt(dateUtil.getExpiredDate())
> >                 .sign(algorithm);
> >     }
> > 
> >     /**
> >      * 解密Token
> >      */
> >     public Map<String, Claim> verifyToken(String token) {
> >         DecodedJWT jwt = null;
> >         try {
> >             JWTVerifier verifier = JWT.require(Algorithm.HMAC256(jwt_secret)).build();
> >             jwt = verifier.verify(token);
> >             return jwt.getClaims();
> >         } catch (JWTDecodeException | SignatureVerificationException | IllegalArgumentException | TokenExpiredException | NullPointerException e) {
> >             throw new BaseRuntimeException("校验失败, 抛出Token验证非法异常", e);
> >         }
> >     }
> > 
> >     /**
> >      * 根据Token获取userId
> >      */
> >     public String getSecretInfo(String token) {
> >         Map<String, Claim> claims = verifyToken(token);
> >         Assert.notNull(claims, "token校验失败");
> >         Claim claim = claims.get("userId");
> >         Assert.notNull(claim, "获取用户信息失败");
> >         Assert.notEmpty(new Object[]{claim.asString()}, "获取用户信息失败");
> >         return claim.asString();
> >     }
> > }
> > ```
> > 调用结果：
> > ```json
> > 
> > {
> >   "code": 1,
> >   "msg": "获取用户信息失败",
> >   "result": null
> > }
> > ```
>
> **试用了下，虽然try-catch得到代码量减少了，但是实际逻辑上来说使用spring assert反而受限，需要特殊情况特殊处理。。**
>
>
>
> 参考文章：
>
> [你这代码写得真丑，满屏的try-catch，全局异常处理不会吗？](https://mp.weixin.qq.com/s/mmlsBljefmW_S00IY88pAw)
>
> [Spring进阶之@ControllerAdvice与统一异常处理](https://juejin.im/post/6844903826412011533)

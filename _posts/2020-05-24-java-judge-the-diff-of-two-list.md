---
layout: post
title: java判断两个List是否相同
date: 2020-05-24 20:03:32
author: 七禾叶
tags: [java]
comments: true
toc: false
pinned: false
---


> 没事干，百度了下Java如何判断两个List内容是否相同，反正我只要能用就成，哈哈

> ```java
>  import java.util.HashMap;
>  import java.util.List;
>  import java.util.Map;
>  
>  /**
>   * @author 七禾叶
>   * @date 2020/5/20
>   */
>  public class CheckDiffList {
>      public static boolean getDiffrent(List<String> list1, List<String> list2) {
>         Map<String, Integer> map = new HashMap<>();
>         if (list1 == null && list2 == null) {
>             return true;
>         }else if (list1 != null && list2 != null){
>             if (list1.size() != list2.size()) {
>                 return false;
>             }
> 
>             for (String string : list1) {
>                 map.put(string, 1);
>             }
>             for (String string : list2) {
>                 Integer cc = map.get(string);
>                 if (cc != null) {
>                     map.put(string, ++cc);
>                 }
>             }
>         }else {
>             return false;
>         }
> 
>         return !map.containsValue(1);
>     }
> 
> 
>     @Test(priority = 1)
>     public void test1() {
>         List<String> list1 = null;
>         List<String> list2 = null;
>         Assert.assertTrue(getDiffrent(list1, list2));
>     }
> 
>     @Test(priority = 2)
>     public void test2() {
>         List<String> list1 = null;
>         List<String> list2 = Arrays.asList(new String[]{"6", "7", "8", "9", "10", "1", "2", "3", "4", "5"});
>         Assert.assertFalse(getDiffrent(list1, list2));
>     }
> 
>     @Test(priority = 3)
>     public void test3() {
>         List<String> list1 = Arrays.asList(new String[]{"1", "2", "3", "4", "5", "6", "7", "8", "9", "10"});
>         List<String> list2 = Arrays.asList(new String[]{"1", "2", "3", "4", "5", "6", "7", "8", "9"});
>         Assert.assertFalse(getDiffrent(list1, list2));
>     }
> 
>     @Test(priority = 4)
>     public void test4() {
>         List<String> list1 = Arrays.asList(new String[]{"1", "2", "3", "4", "5", "6", "7", "8", "9"});
>         List<String> list2 = Arrays.asList(new String[]{"1", "2", "3", "4", "5", "6", "7", "8", "9", "10"});
>         Assert.assertFalse(getDiffrent(list1, list2));
>     }
> 
>     @Test(priority = 5)
>     public void test5() {
>         List<String> list1 = Arrays.asList(new String[]{"1", "2", "3", "4", "5", "6", "7", "8", "9", "10"});
>         List<String> list2 = Arrays.asList(new String[]{"11", "2", "3", "4", "5", "6", "7", "8", "9", "10"});
>         Assert.assertFalse(getDiffrent(list1, list2));
>     }
> 
>     @Test(priority = 6)
>     public void test6() {
>         List<String> list1 = Arrays.asList(new String[]{"1", "2", "3", "4", "5", "6", "7", "8", "9", "10"});
>         List<String> list2 = Arrays.asList(new String[]{"1", "2", "3", "4", "5", "6", "7", "8", "9", "10"});
>         Assert.assertTrue(getDiffrent(list1, list2));
>     }
> 
>     @Test(priority = 7)
>     public void test7() {
>         List<String> list1 = Arrays.asList(new String[]{"1", "2", "3", "4", "5", "6", "7", "8", "9", "10"});
>         List<String> list2 = Arrays.asList(new String[]{"6", "7", "8", "9", "10", "1", "2", "3", "4", "5"});
>         Assert.assertTrue(getDiffrent(list1, list2));
>     }
> 
>     @Test(priority = 8)
>     public void test8() {
>         List<String> list1 = Arrays.asList(new String[]{});
>         List<String> list2 = Arrays.asList(new String[]{});
>         Assert.assertTrue(getDiffrent(list1, list2));
>     }
> 
>     @Test(priority = 9)
>     public void test9() {
>         List<String> list1 = Arrays.asList(new String[]{});
>         List<String> list2 = Arrays.asList(new String[]{""});
>         Assert.assertFalse(getDiffrent(list1, list2));
>     }
> 
>     @Test(priority = 10)
>     public void test10() {
>         List<String> list1 = Arrays.asList(new String[]{""});
>         List<String> list2 = Arrays.asList(new String[]{""});
>         Assert.assertTrue(getDiffrent(list1, list2));
>     }
> ```
> ![J2ORyrTlcEa1fA8](https://i.loli.net/2020/05/24/J2ORyrTlcEa1fA8.png)

>相应链接地址：[Java判断两个List是否相同](https://www.jianshu.com/p/e96216367a81?from=singlemessage)

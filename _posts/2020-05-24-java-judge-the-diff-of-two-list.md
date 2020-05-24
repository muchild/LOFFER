---
layout: post
title: java判断两个List是否相同
date: 2020-05-24 20:03:32
author: 七禾叶
tags: [Java]
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
>         boolean flag = true;
>         Map<String, Integer> map = new HashMap<String, Integer>(list1.size() + list2.size());
>         List<String> maxList = list1;
>         List<String> minList = list2;
> 
>         if (list2.size() > list1.size()) {
>             maxList = list2;
>             minList = list1;
>         }else if (list1.size() != list2.size()){
>             return false;
>         }
> 
>         for (String string : maxList) {
>             map.put(string, 1);
>         }
>         for (String string : minList) {
>             Integer cc = map.get(string);
>             if (cc != null) {
>                 map.put(string, ++cc);
>             }
>         }
>         for (String string : maxList) {
>             if (map.get(string) == 1){
>                 flag = false;
>                 break;
>             }
>         }
>         return flag;
>     }
> 
>     @Test
>     public void test1(){
>         List<String> list1 = Arrays.asList(new String[]{"1","2","3","4","5","6","7","8","9","10"});
>         List<String> list2 = Arrays.asList(new String[]{"1","2","3","4","5","6","7","8","9"});
>         System.out.print(getDiffrent(list1, list2));
>     }
> 
>     @Test
>     public void test2(){
>         List<String> list1 = Arrays.asList(new String[]{"1","2","3","4","5","6","7","8","9"});
>         List<String> list2 = Arrays.asList(new String[]{"1","2","3","4","5","6","7","8","9","10"});
>         System.out.print(getDiffrent(list1, list2));
>     }
> 
>     @Test
>     public void test3(){
>         List<String> list1 = Arrays.asList(new String[]{"1","2","3","4","5","6","7","8","9","10"});
>         List<String> list2 = Arrays.asList(new String[]{"11","2","3","4","5","6","7","8","9","10"});
>         System.out.print(getDiffrent(list1, list2));
>     }
> 
>     @Test
>     public void test4(){
>         List<String> list1 = Arrays.asList(new String[]{"1","2","3","4","5","6","7","8","9","10"});
>         List<String> list2 = Arrays.asList(new String[]{"1","2","3","4","5","6","7","8","9","10"});
>         System.out.print(getDiffrent(list1, list2));
>     }
> 
>     @Test
>     public void test5(){
>         List<String> list1 = Arrays.asList(new String[]{});
>         List<String> list2 = Arrays.asList(new String[]{""});
>         System.out.print(getDiffrent(list1, list2));
>     }
> 
>     @Test
>     public void test6(){
>         List<String> list1 = Arrays.asList(new String[]{});
>         List<String> list2 = Arrays.asList(new String[]{});
>         System.out.print(getDiffrent(list1, list2));
>     }
>  }
> ```
> ![OUvqbYsdorGpKew](https://i.loli.net/2020/05/24/OUvqbYsdorGpKew.png)

>相应链接地址：[Java判断两个List是否相同](https://www.jianshu.com/p/e96216367a81?from=singlemessage)

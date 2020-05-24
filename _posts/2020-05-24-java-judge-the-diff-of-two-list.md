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
> import java.util.HashMap;
>  import java.util.List;
>  import java.util.Map;
>  
>  /**
>   * @author guoying
>   * @date 2020/5/20
>   */
>  public class CheckDiffList {
>      /**
>       * 判断两个List内的元素是否相同
>       *
>       * @param list1
>       * @param list2
>       * @return
>       */
>      public static boolean getDiffrent(List<String> list1, List<String> list2) {
>          Boolean flag = true;
>          Map<String, Integer> map = new HashMap<String, Integer>(list1.size() + list2.size());
>          List<String> maxList = list1;
>          List<String> minList = list2;
>          if (list2.size() > list1.size()) {
>              maxList = list2;
>              minList = list1;
>          }
>          for (String string : maxList) {
>              map.put(string, 1);
>          }
>          for (String string : minList) {
>              Integer cc = map.get(string);
>              if (cc != null) {
>                  map.put(string, ++cc);
>              }
>          }
>  
>          for (String string : maxList) {
>              if (map.get(string) == 1){
>                  flag = false;
>                  break;
>              }
>          }
>          return flag;
>      }
>  }
> ```
>
>相应链接地址：[Java判断两个List是否相同](https://www.jianshu.com/p/e96216367a81?from=singlemessage)

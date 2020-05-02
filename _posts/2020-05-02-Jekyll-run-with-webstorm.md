---
layout: post
title: 使用webstorm预览jekyll项目
date: 2020-05-02 17-09-08
author: 七禾叶
tags: [blog]
comments: true
toc: true
pinned: true
---



> 也是个神奇的事吧，tjj去找了个博客模板支持了友情链接，那我也要把他的blog链接过来，方便你我他。。嘿嘿

#### [一、webstorm里添加post文章的模板](https://hadihariri.com/2014/01/04/using-webstorm-to-maintain-a-jekyll-site/)
>```markdown
> webstorm -> Preferences -> Editor -> File and Code Templates, new File, 配置如下：
> 模板内容如下：
>---
> layout: post
> title: $title
> date: ${YEAR}-${MONTH}-${DAY} ${HOUR}-${MINUTE}-${SECOND}
> author: 七禾叶
> tags: [$tags]
> comments: true
> toc: true
> pinned: true
> ---
> ```


#### 二、配置webtorm可预览
>```markdown 
> 1、gem install -n /usr/local/bin jekyll jekyll-sitemap jekyll-feed jekyll-paginate
> 2、配置webstorm configuration
>   A、Edit configuration (需要提前安装Bash Script插件哈)
>   B、选择 + Bash(name: kill) 
>         a、script: /bin/sh script.sh
>         b、interpreter path: /bin/sh
>         c、interpreter options: script.sh
>   C、选择 + Bash(name: jekyll) 
>         a、script: /usr/local/bin/jekyll serve --detach
>         b、interpreter path: /usr/local/bin/jekyll
>         c、interpreter options: serve --detach
>   D、选择 + attach to Node.js/Chrome (name: jelly post to chrome) 
>         a、Before Launch -> Run Another Configuration -> Bash -> kill
>         b、Before Launch -> Run Another Configuration -> Bash -> jekyll
>         c、Before Launch -> Run Another Configuration -> Launch Web Browser -> 输入需要打开的调试地址
>   D、保存
> 3、debug
>   ```

> **这样，运行jekyll项目的时候，就可以直接默认浏览器打开预览啦。。**

#### 三、备注
> ```markdown
> $ jekyll serve
> # => 一个开发服务器将会运行在 http://localhost:4000/
> # Auto-regeneration（自动再生成文件）: 开启。使用 `--no-watch` 来关闭。
>
> $ jekyll serve --detach
> # => 功能和`jekyll serve`命令相同，但是会脱离终端在后台运行。
> #    如果你想关闭服务器，可以使用`kill -9 1234`命令，"1234" 是进程号（PID）。
> #    如果你找不到进程号，那么就用`ps aux | grep jekyll`命令来查看，然后关闭服务器
>
> 相关文章：https://jekyllcn.com/docs/usage
>```

> script.sh
> ```bash
>#!/usr/bin/env bash
> 
> x=`lsof -i tcp:4000 -t| awk '{print $1}'`
> echo $x
> 
> if [[ -n $x ]];
> then
>   kill -9 $x;
> fi
```


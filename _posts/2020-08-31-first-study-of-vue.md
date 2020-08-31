---
layout: post
title: vue初次学习
date: 2020-08-31 21:43:18
author: 七禾叶
tags: [前端]
comments: true
toc: false
pinned: false
---

> 大概是我真的太无聊了吧。。

### 一、nvm介绍
> nvm is a version manager for node.js, designed to be installed per-user, and invoked per-shell. nvm works on any POSIX-compliant shell (sh, dash, ksh, zsh, bash), in particular on these platforms: unix, macOS, and windows WSL.
> [github地址](https://github.com/nvm-sh/nvm)

### 二、nvm安装
> ```bash
> curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
> 按照命令行安装后的提示修改bash_profile
> nvm ls-remote # 查看node远程版本
> nvm install v12.18.3 # 安装目标版本
> ```

### 三、vue创建项目
> ```bash
> npm install --global vue-cli
> cd /target # 进入目标文件夹
> vue init webpack jwt-demo
> ```

### 四、工程目录
> ![1.png](https://i.loli.net/2020/08/30/BY6Hw3Wlr42AQvu.png)

### 五、安装vuetify ui库
> **简便的安装vuetify ui库**
> ```shell
> vue add vuetify
> ```
> 
> 以下为：Webpack 安装
> ```bash
> npm install vuetify
> npm install sass sass-loader fibers deepmerge -D
>```
> 修改webpack.config.js
> ```javascript
> // webpack.config.js
> module.exports = {
>   rules: [
>     {
>       test: /\.s(c|a)ss$/,
>       use: [
>         'vue-style-loader',
>         'css-loader',
>         {
>           loader: 'sass-loader',
>           // Requires sass-loader@^7.0.0
>           options: {
>             implementation: require('sass'),
>             fiber: require('fibers'),
>             indentedSyntax: true // optional
>               sassOptions: {
>               fiber: require('fibers'),
>               indentedSyntax: true // optional
>             },
>           },
>         },
>       ],
>     },
>   ],
> }
> ```
>
> ```javascript
> // src/plugins/vuetify.js
> 
> import Vue from 'vue'
> import Vuetify from 'vuetify'
> import 'vuetify/dist/vuetify.min.css'
> 
> Vue.use(Vuetify)
> 
> const opts = {}
> 
> export default new Vuetify(opts)
> ```
>
> ```javascript
> // src/main.js
> 
> import Vue from 'vue'
> import App from './App'
> import router from './router'
> import vuetify from './plugins/vuetify'
> 
> Vue.config.productionTip = false
> 
> /* eslint-disable no-new */
> new Vue({
>   el: '#app',
>   router,
>   components: { App },
>   template: '<App/>',
>   vuetify
> })
> ```
>
> ```html
> //index.html
> 
> <link href="https://fonts.googleapis.com/css?family=Roboto:100,300,400,500,700,900" rel="stylesheet">
> <link href="https://cdn.jsdelivr.net/npm/@mdi/font@5.x/css/materialdesignicons.min.css" rel="stylesheet">
> ```
> **还是多看官方文档吧**。。官网文档：[地址](https://vuetifyjs.com/en/getting-started/quick-start)

### 7、修改代码一个按钮
> ```html
> <template>
>   <v-app>
>     <div class="hello">
>       <v-btn @click="click()">button</v-btn>
>     </div>
>   </v-app>
> </template>
> 
> <script>
> let count = 0
> export default {
>   name: 'HelloWorld',
>   methods: {
>     click: function () {
>       count += 1
>       console.log(count, '！！')
>       if (count % 2 === 0) {
>         alert('TEST!!!')
>       }
>     }
>   }
> }
> </script>
> 
> ```

### 七、启动项目
> ```node
> npm run dev
> ```
> 运行后效果
> ![1.png](https://i.loli.net/2020/08/31/oLH8MvNdcTzPS2s.png)

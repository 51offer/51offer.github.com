title: 用 travis-ci 自动部署 hexo 静态博客
date: 2015-07-11 15:55:22
author: mithvv@gmail.com
tags: blog, tools, ci
categories: tools
---

各种静态博客引擎中，hexo 已经算比较方便，`hexo deploy --generate` 一条命令搞定部署工作。

我们团队成员在写静态博客的时候，碰到一些情况想把这一步也省掉：
- 本地没装 hexo，只想写篇文章就 push
- push 都不想，只在 github 上修改文章内容
- 我就是懒，一行 deploy 命令也懒得打

……也都挺有道理。我们看看怎么用 travis-ci 搞定 hexo 自动部署。

## 实现

hexo 的作者写了篇文章介绍了自动部署，请[参考这里](http://zespia.tw/blog/2015/01/21/continuous-deployment-to-github-with-travis/)。

- 设置 deploy key

```shell
ssh-keygen -t rsa -C "your_email@example.com"
# 注意指定 file_key，此处为 travis_key, passphrase 为空
# 之后会生成 travis_key 和 travis_key.pub 两个文件， 把 travis_key.pub 设置到 https://github.com/settings/ssh 中

travis encrypt-file travis_key --add
# 这里会生成 travis_key.enc 文件，同时在 .travis.yml 中新增 openssl 一行

```

- 设置 .travis.yml, 附上最终配置

```yml
language: node_js


node_js:
- '0.12'


before_install:
- npm install hexo -g

# config for `hexo deploy`
- openssl aes-256-cbc -K $encrypted_4dbc5423f685_key -iv $encrypted_4dbc5423f685_iv
  -in .travis/travis_key.enc -out ~/.ssh/id_rsa -d
- chmod 600 ~/.ssh/id_rsa
- eval $(ssh-agent)
- ssh-add ~/.ssh/id_rsa
- cp .travis/ssh_config ~/.ssh/config
- git config --global user.name "travis_bot"
- git config --global user.email "mithvv@gmail.com"


script:
- hexo generate
- hexo deploy


branches:
  only:
  - blog
```

- 在 https://travis-ci.org 网站启用对应项目
- 之后每次有新的 push 或 pull-request，travis-ci 都会自动 build，根据 build log 调试
- 把 [![Build Status](https://travis-ci.org/51offer/51offer.github.com.svg?branch=blog)](https://travis-ci.org/51offer/51offer.github.com) 加到项目介绍中，Enjoy！


## 一些 tips
- repo-setting 中设置 default branch 为 blog，这样访问项目首页直接显示源文件
- 注意开源项目不要提交 travis_key & travis_key.pub 文件 ；）
- travis-ci 每次 build 前自动 clone（参见 build log），所以我认为 hexo 作者配置中的 git clone 是不必要的

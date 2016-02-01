title: Why Git? Learn It!
date: 2016-01-06 16:00:00
tags:
- git

categories: 技术部分享
---

## 总览

- 为什么要用 Git？
- Git + SourceTree + Gitlab 的使用演示
- 提醒和推荐

## 为什么要用 Git？

- 一个工具、一套方案，解决源码管理的问题

### 对于版本控制，我们需要什么？

- 代码历史追溯
	- 某一次提交的改动（SVN，Git）
	- 某一个功能的改动过程（好的提交习惯更重要，在多人协作情况下提交历史更清晰）
- 协同开发
	- 用分支来隔离上线与开发中的代码
	- 多人多线并行开发：1 人对 N 线，N 人对 1 线都有可能

> 秒极定律  
> 一件事情如果能控制在 10s 内完成，人们就会极频繁的使用它。  
> 举栗子：
>  - docker 被推崇，从虚拟机到 Vagrant 到 docker，碰到了秒级定律
>  - 持续集成，快速迭代

### 秒级的代码管理？

- 本地代码飞快变化至任意历史提交记录：SVN 30s-2min；Git 秒级
	- 工作状态快速切换
- 代码提交速度飞快：SVN 受限于网络速度；Git commit 秒级，push 受限于网络速度
- 代码创建、切换、合并分支飞快：SVN 速度慢，很麻烦；Git 赞！
	- 勇于原型探索，历史清晰，易调整方向，易新建，易弃用
	- 与 code review 结合

## SVN 比 Git 好在哪里

- 更简单，符合原有自主文件夹管理版本的心理预期
	- Git 暴露概念过多，学习曲线陡峭，这点不如 hg
- SVN 有目录级的权限控制
	- 适合大中型中间件软件公司：目录划分权限，职能长期固定
- 也许还有其它，我不清楚

### Git 真实的影响力

> I'm an egotistical bastard, and I name all my projects after myself. First Linux, now Git.  
> —— Linus

- 在 2016 问这个问题对互联网来说已是大势所趋
	- npm + pip 均托管在 Github
	- OpenJDK 使用 Hg（Mercurial）
	- Github 早已一统开源天下，Java 概莫能外
- SVN 与 Git 二分天下，但 Git 占据的是互联网明星创业公司和 BAT 的优秀团队，为何？
- 会 Git 找工作是加分项
- 学习版本控制的另一种思维方式（学习一门语言就是学习一类思维方式）

## 一些问题
- Git 不能直接解决目前后端的开发环境
	- code 规范的 branch 流程
	- 依赖，理清 maven 依赖和配合方式
	- 秒级上线（测试、预发布、正式）
	- 相应（尽可能少人力介入的）自动化测试、监控

## Git + SourceTree + Gitlab 的使用演示

![Git 使用流程示意图](http://7j1xgb.com5.z0.glb.clouddn.com/FullSizeRender.jpg)

### local repo

- 用 SourceTree 初始化一个本地项目
- 小步提交，介绍 staged 的用法
	- stage or unstage or discard
	- stage 某一行代码
- 一次提交
- 介绍 master 分支及 branchs 界面
	- 留意 commit 编号
- 创建一个分支 feature/login
- 新建 login.java 文件，index.html 加一行代码
- commit，观察分支树变化
- 切换分支，观察代码变化
- 创建一个分支 feature/share
- 新建 share.py 文件，index.html 改一行代码
- commit，观察分支树变化
- 切回 feature/login，临时处理事情，再切回 feature/share
- feature/share 分支删几行代码，再提交一次
- feature/share merge to master 分支，观察分支树变化
- feature/login merge to master 分支，处理冲突
- 初始化 Git-flow
- 新建 feature/school 分支，commit once
- 用 Git-flow-gui 完成 feature/school 分支
- 留意刚才的所有提交都在本地，思考与 SVN 区别（很像，只是分支极灵活）
- Q&A

### Gitlab

- 注册帐号，ssh-key 授权（略）
- 介绍 Gitlab 结构：team-project
- 新建项目 test-repo
- 留意空项目向导，复制代码库 url
- 本地配置 remote-url，观察 remotes 变化
- push，注意是 push 多条分支，留意 local-remote 分支对应关系
- 再看 remotes 变化，分支树变化
	- remotes branchs 与 local branchs 一致
	- 分支树中多了 origin/*
- 观察 Gitlab 界面变化
- 介绍 Gitlab 单个项目界面
- Q&A

### 来一次典型的开发过程（包含 code review）

- 保证在 develop 分支，pull 最新代码
- 网页端提交 readme 文件，造成 origin 变化，介绍 fetch，注意 branchs 变化
- 重新 pull
- 用 Git-flow-gui 建立 feature/news 分支
- 产生两次 commit（包含 rename 文件）
- 留意分支树变化，注意 Gitlab-web 端不存在刚才的提交，push，再对比
- Gitlab-web 端新建 merge-request, 留意 source-branch, target-branch, title, ass
- 被指派者 review 代码，web 端回复建议
- 根据建议产生新的 commit，同时 push
- 刷新 web 端观察变化：查看一次 commit，查看全部 changes
- 被指派者回复 LGTM（look good to me），点击 merge
- 回到 SourceTree，观察分支树变化，fetch 再看
- 切回 develop 分支
- Q&A
	- 有冲突 merge 按钮会不可点击，merge develop to work_branch ，在 develop 分支外解决冲突，commit&push，merge 按钮就可点击了
	- 可方便的与自动化测试等结合起来

## 提醒和推荐

## 一些提醒（坑）
- 初次使用 Git，注意设置 `git config --global email&name`
- Windows 下的 Git 使用的确有些不便（不过我不熟悉，也不清楚具体问题）
- 授权方式推荐 ssh-key
- 忽略文件的配置
- 着手代码前思考终极问题：『我在哪里，要去何处？』（先认清所在分支，pull）
- commit 已经 push 到远端了，这个时候不要想着再去修改了
- 学习新东西，坑总是有的，多填了也就会了

### 一些推荐

- 强调思路，记住秒级定律，效率为王
- 小步提交，每小时至少提交一次
	- 一次任务的实现过程：整体设计，框架（类），接口，单元测试，实现
- 完整提交，完整提交，必须完整提交！不该有任一个提交项目不可运行。
- 保证非工作期间，工作区间干净
- 不想提交但要切换分支处理事物用 stash 处理
- Github 经常被 X
	- coding.net 代码私有库托管可以用。找开源代码，永远是 Github
	- Google 也是被 X。珍爱生命，自配 VPN
- 国内 Git 私有库托管推荐 coding.net，国外推荐 bitbucket（支持hg） 和 Gitlab

## 其它
- 依赖（迷信）工具不可取，但工具会影响思维方式，而思维方式非常重要

> 举例：  
> SVN 的思维方式决定了 diff patch 的开源合作方式。交流不顺畅，实现思路难以程现，这种合作方式很长时间里都是高端人士的特权。  
> Git + Github 催生了 fork，成就了最大的程序员社交网站，也极力促进了开源社区的发展。

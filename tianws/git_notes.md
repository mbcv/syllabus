# Git笔记
## 在Linux上安装Git
试着输入git，看看系统有没有安装Git，如果没有安装，用以下语句
> sudo apt-get install git
##创建版本库
1. 选择一个合适的地方，创建空目录
>  mkdir git
>  cd git
2. 通过以下命令把这个目录变成Git可以管理的仓库
> git init

用 ls -ah 可以看见隐藏文件，.git目录是Git用来跟踪管理版本库的。

3. 把文件添加到版本库
把文件放到Git仓库
> git add file1.txt
> git add file2.txt
> git commit -m "add 2 files."

-m 后面输入的是本次提交说明

## 时光机穿梭
用这条命令来查看仓库当前的状态
> git status 

查看difference
> git diff  readme.txt
	
然后可以add和commit
###1. 版本回退
查看从最近到最远的提交日志
> git log

嫌输出太乱加上参数
> git log --pretty=oneline
> 3628164fb26d48395383f8f31179f24e0882e1e0       append GPL
> ea34578d5496d7dd233c827ed32a8cd576c5ee85 add distributed
> cb926e7ea50ad11b8f9e909c05226233bf755030    wrote a readme file

前面是的一串是commit id
HEAD表示当前版本，上一个版本是HEAD^，上上版本是HEAD^^，往上100个写成HEAD～100
回退到上一个版本
> git reset  - -hard HEAD^
	
已知commit id 也可以直接回退
> git reset - -hard 3628164
> HEAD is now at 3628164 append GPL
	
版本号写前几位Git会自动去找
如果回退后又想恢复新版本，可以先找到新版本的commit id，再reset
> git reflog

### 2. 工作区和暂存区
####(1) 工作区
就是我们能看到的目录
####(2) 版本库
就是.git隐藏目录
里面有一个暂存区（stage或者叫index），还有Git为我们创建的第一个分支master，以及指向master的一个指针HEAD。
![](http://www.liaoxuefeng.com/files/attachments/001384907702917346729e9afbf4127b6dfbae9207af016000/0)
*git add 实际上是把文件修改添加到暂存区(相当于购物车？)*
*git commit 实际上是把暂存区的所有内容提交到当前分支（确认执行付款）*
> git diff    #是工作区(work dict)和暂存区(stage)的比较
> git diff --cached    #是暂存区(stage)和分支(master)的比较
> git diff HEAD - - readme.txt  #是工作区和版本库最新版本的区别
###3.管理修改
每次commit的内容都是add之后的，如果没有add将不会commit
###4.撤销修改
用暂存区替换工作区
> git checkout - - file

用branch(当前版本)替换暂存区
> git reset HEAD file

如果commit过了，就用前文讲过的版本回退
> git reset - -hard 3628164

###5.删除文件
> git rm #用于从版本库中删除文件（其实是删除的暂存区的文件，branch中的还可以通过git reset HEAD 恢复暂存区）
> git checkout #用版本库里的版本替换工作区的版本
##远程仓库
1. 创建SSH key
用户主目录-->.ssh目录-->id_rsa是私钥，id_rsa.pub是公钥
如果没有，用下面语句创建
> ssh-keygen -t rsa -C "youremail@example.com"

邮箱用自己的，然后一路回车

2. 登陆GitHub-->Account settings-->SSH Keys
添加SSH Key（id_rsa.pub文件里的内容）

###1. 查看当前的远程库
在工作区用命令
> git remote (-v) #-v表示详细信息

###2. 添加远程库
可以指定一个简单的名字，以便将来引用
> git remote add [shortname] [url]
> [url]一般形式为git@server-name:path/repo-name.git
> 如 git@github.com:tianws/Hello.git

【例】
>  git remote
> origin
>  git remote add pb git://github.com/paulboone/ticgit.git
>  git remote -v
> origin  git://github.com/schacon/ticgit.git
> pb  git://github.com/paulboone/ticgit.git

现在可以用字符串pb指代对应的仓库地址了，比如要抓取所有Paul有的，但本地仓库没有的信息，可以运行
> git fetch pb

如果远程库是空的，可以执行下面的语句
> git push -u origin master
	
把本地master分支的所有内容推送到远程库上，由于远程库是空的，所以加了-u参数，不但会把本地master分支推送到远程新的master分支，还会把本地的master分支和远程的master分支关联起来。
可以看到远程库的内容已经和本地一模一样，从现在起，只要本地做了修改，就可以通过命令把本地master分支的最新修改推送至GitHub。
> git push origin master

###3.  从远程库抓取数据
> git fetch [remote-name]

此命令会到远程仓库中拉取所有你本地仓库中还没有的数据。运行完成后，你就可以在本地访问该远程仓库中的所有分支，将其中某个分支合并到本地，或者只是取出某个分支。
有一点很重要，需要记住，fetch 命令只是将远端的数据拉到本地仓库，并不自动合并到当前工作分支，只有当你确实准备好了，才能手工合并。
###4. 查看远程库信息
> git remote show [remote-name]

###5. 远程仓库的删除和重命名
> git remote rename pb paul  #把pb改成pual
> git remote rm paul    #删除远程库paul

##分支管理
### 1. 创建与合并分支
a.  master分支是主分支，HEAD指向当前分支
![](http://www.liaoxuefeng.com/files/attachments/0013849087937492135fbf4bbd24dfcbc18349a8a59d36d000/0)
b. 创建分支dev，再把HEAD指向dev
> git checkout -b dev #git checkout命令加上-b参数表示创建并切换，相当于以下两条命令：
> git branch dev
> git checkout dev

然后，用git branch命令查看当前分支：
> git branch

![](http://www.liaoxuefeng.com/files/attachments/001384908811773187a597e2d844eefb11f5cf5d56135ca000/0)

c. 在dev分支修改后add并commit
![](http://www.liaoxuefeng.com/files/attachments/0013849088235627813efe7649b4f008900e5365bb72323000/0)
d. dev分支的工作完成，我们就可以切换回master分支：
> git checkout master

![](http://www.liaoxuefeng.com/files/attachments/001384908892295909f96758654469cad60dc50edfa9abd000/0)
e. 把dev分支的工作成果合并到master分支上：
> git merge dev
> Updating d17efd8..fec145a
> Fast-forward
> readme.txt |    1 +
> 1 file changed, 1 insertion(+)

注意到上面的Fast-forward信息，Git告诉我们，这次合并是“快进模式”，也就是直接把master指向dev的当前提交，所以合并速度非常快。

当然，也不是每次合并都能Fast-forward，我们后面会讲其他方式的合并。
f. 合并完成后，就可以放心地删除dev分支了：
> git branch -d dev

删除后，查看branch，就只剩下master分支了：
> git branch
> * master

####小结
查看分支：git branch

创建分支：git branch < name>

切换分支：git checkout < name>

创建+切换分支：git checkout -b < name>

合并某分支到当前分支：git merge < name>

删除分支：git branch -d < name>
###2. 解决冲突
如果两个分支都有不同的commit，如下图
![](http://www.liaoxuefeng.com/files/attachments/001384909115478645b93e2b5ae4dc78da049a0d1704a41000/0)
这种情况下，Git无法执行“快速合并”，只能试图把各自的修改合并起来，但这种合并可能会有冲突，我们试试看：
```
$ git merge feature1
Auto-merging readme.txt
CONFLICT (content): Merge conflict in readme.txt
Automatic merge failed; fix conflicts and then commit the result.
```

果然冲突了！Git告诉我们，readme.txt文件存在冲突，必须手动解决冲突后再提交。git status也可以告诉我们冲突的文件：
```
$ git status
# On branch master
# Your branch is ahead of 'origin/master' by 2 commits.
#
# Unmerged paths:
#   (use "git add/rm <file>..." as appropriate to mark resolution)
#
#       both modified:      readme.txt
#
no changes added to commit (use "git add" and/or "git commit -a")
```
我们可以直接查看readme.txt的内容：
```
Git is a distributed version control system.
Git is free software distributed under the GPL.
Git has a mutable index called stage.
Git tracks changes of files.
<<<<<<< HEAD
Creating a new branch is quick & simple.
=======
Creating a new branch is quick AND simple.Bug分支
>>>>>>> feature1
```
Git用<<<<<<<，=======，>>>>>>>标记出不同分支的内容，我们修改后保存，再add，commit
现在，master分支和feature1分支变成了下图所示：
![](http://www.liaoxuefeng.com/files/attachments/00138490913052149c4b2cd9702422aa387ac024943921b000/0)
用带参数的git log也可以看到分支的合并情况：git log --graph 可以看合并分支图
```
$ git log --graph --pretty=oneline --abbrev-commit
*   59bc1cb conflict fixed
|\
| * 75a857c AND simple
* | 400b400 & simple
|/
* fec145a branch test
...
```
最后，删除feature1分支：
```
$ git branch -d feature1
Deleted branch feature1 (was 75a857c).

```
###3.分支管理策略
####a. 强制禁用Fast forward模式
通常，合并分支时，如果可能，Git会用Fast forward模式，但这种模式下，删除分支后，会丢掉分支信息。

如果要强制禁用Fast forward模式，Git就会在merge时生成一个新的commit，这样，从分支历史上就可以看出分支信息。

简单来说，合并分支时，加上--no-ff参数就可以用普通模式合并，合并后的历史有分支，能看出来曾经做过合并，而fast forward合并就看不出来曾经做过合并。

![](http://static.oschina.net/uploads/img/201406/05112016_pWF5.png)
![](http://static.oschina.net/uploads/img/201406/05112016_t19t.png)

下面我们实战一下--no-ff方式的git merge：
```
$ git merge --no-ff -m "merge with no-ff" dev
Merge made by the 'recursive' strategy.
 readme.txt |    1 +
 1 file changed, 1 insertion(+)
```
--no-ff参数，表示禁用Fast forward
因为本次合并要创建一个新的commit，所以加上-m参数，把commit描述写进去。

合并后，我们用git log看看分支历史：
```
$ git log --graph --pretty=oneline --abbrev-commit
*   7825a50 merge with no-ff
|\
| * 6224937 add merge
|/
*   59bc1cb conflict fixed
...
```
可以看到，不使用Fast forward模式，merge后就像这样：
![](http://www.liaoxuefeng.com/files/attachments/001384909222841acf964ec9e6a4629a35a7a30588281bb000/0)
####b. 分支策略

在实际开发中，我们应该按照几个基本原则进行分支管理：

首先，master分支应该是非常稳定的，也就是仅用来发布新版本，平时不能在上面干活；

那在哪干活呢？干活都在dev分支上，也就是说，dev分支是不稳定的，到某个时候，比如1.0版本发布时，再把dev分支合并到master上，在master分支发布1.0版本；

你和你的小伙伴们每个人都在dev分支上干活，每个人都有自己的分支，时不时地往dev分支上合并就可以了。

所以，团队合作的分支看起来就像这样：
![](http://www.liaoxuefeng.com/files/attachments/001384909239390d355eb07d9d64305b6322aaf4edac1e3000/0)
###4. Bug分支
**情景：**在dev上开发新功能，但未完工不能提交，这时master上有bug需要修复。
**步骤1：**把当前工作现场“储藏”起来，等以后恢复现场后继续工作：
```
$ git stash
Saved working directory and index state WIP on dev: 6224937 add merge
HEAD is now at 6224937 add merge
```
用git status查看工作区，就是干净的（除非有没有被Git管理的文件），因此可以放心地创建分支来修复bug。

**步骤2：**首先确定要在哪个分支上修复bug，假定需要在master分支上修复，就从master创建临时分支：
```
$ git checkout master
Switched to branch 'master'
Your branch is ahead of 'origin/master' by 6 commits.
$ git checkout -b issue-101
Switched to a new branch 'issue-101'
```
**步骤3：**修复bug，然后提交：
```
$ git add readme.txt 
$ git commit -m "fix bug 101"
[issue-101 cc17032] fix bug 101
 1 file changed, 1 insertion(+), 1 deletion(-)
```
**步骤4：**修复完成后，切换到master分支，并完成合并，最后删除issue-101分支：
```
$ git checkout master
Switched to branch 'master'
Your branch is ahead of 'origin/master' by 2 commits.
$ git merge --no-ff -m "merged bug fix 101" issue-101
Merge made by the 'recursive' strategy.
 readme.txt |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
$ git branch -d issue-101
Deleted branch issue-101 (was cc17032).
```
**步骤5：**切换回我们开发的分支，工作区是干净的，用git stash list命令查看保存的工作现场：
```
$ git checkout dev
Switched to branch 'dev'
$ git status
# On branch dev
nothing to commit (working directory clean)
$ git stash list
stash@{0}: WIP on dev: 6224937 add merge
```
**步骤6：**不急着恢复工作现场，先把master分支和当前dev分支（内容是dev最近的一次commit）进行merge（可以选择--no-ff）
```
$ git merge master 
更新 e1ca538..9ef0a28
Fast-forward
 aaa | 1 +
 1 file changed, 1 insertion(+)
```
**步骤6：**提取工作区内容,这时会自动合并
```
$ git stash pop
# On branch dev
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#       new file:   hello.py
#
# Changes not staged for commit:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working directory)
#
#       modified:   readme.txt
#
Dropped refs/stash@{0} (f624f8e5f082f2df2bed8a4e09c12fd2943bdd40)
```
*注：1.用git stash apply恢复，但是恢复后，stash内容并不删除，你需要用git stash drop来删除；
2.用git stash pop，恢复的同时把stash内容也删了：*
可以多次stash，恢复的时候，先用git stash list查看，然后恢复指定的stash，用命令：
	$ git stash apply stash@{0}
##5. Feature分支
和前面差不多，主要是介绍了怎么删除一个分支：
如果要删除的分支还没有合并，那么用-d删除失败：
```
$ git branch -d feature-vulcan
error: The branch 'feature-vulcan' is not fully merged.
If you are sure you want to delete it, run 'git branch -D feature-vulcan'.
```
可以强行删除：
```
$ git branch -D feature-vulcan
Deleted branch feature-vulcan (was 756d4af).
```
###6. 多人协作
当你从远程仓库克隆时，实际上Git自动把本地的master分支和远程的master分支对应起来了，并且，远程仓库的默认名称是origin。

要查看远程库的信息，用git remote：
```
$ git remote
origin
```
或者，用git remote -v显示更详细的信息：
```
$ git remote -v
origin  git@github.com:michaelliao/learngit.git (fetch)
origin  git@github.com:michaelliao/learngit.git (push)
```
上面显示了可以抓取和推送的origin的地址。如果没有推送权限，就看不到push的地址。
###1. 推送分支
推送分支，就是把该分支上的所有本地提交推送到远程库。推送时，要指定本地分支，这样，Git就会把该分支推送到远程库对应的远程分支上：

	$ git push origin master
如果要推送其他分支，比如dev，就改成：

	$ git push origin dev
但是，并不是一定要把本地分支往远程推送，那么，哪些分支需要推送，哪些不需要呢？

- master分支是主分支，因此要时刻与远程同步；

- dev分支是开发分支，团队所有成员都需要在上面工作，所以也需要与远程同步；

- bug分支只用于在本地修复bug，就没必要推到远程了，除非老板要看看你每周到底修复了几个bug；

- feature分支是否推到远程，取决于你是否和你的小伙伴合作在上面开发。
###2. 抓取分支
多人协作的工作模式通常是这样：

1. 首先，可以试图用git push origin branch-name推送自己的修改；

2. 如果推送失败，则因为远程分支比你的本地更新，需要先用git pull试图合并；

3. 如果合并有冲突，则解决冲突，并在本地提交；

4. 没有冲突或者解决掉冲突后，再用git push origin branch-name推送就能成功！

如果git pull提示“no tracking information”，则说明本地分支和远程分支的链接关系没有创建，用命令git branch --set-upstream branch-name origin/branch-name。

###3. 小结
- 查看远程库信息，使用git remote -v；

- 本地新建的分支如果不推送到远程，对其他人就是不可见的；

- 从本地推送分支，使用git push origin branch-name，如果推送失败，先用git pull抓取远程的新提交；

- 在本地创建和远程分支对应的分支，使用git checkout -b branch-name origin/branch-name，本地和远程分支的名称最好一致；

- 建立本地分支和远程分支的关联，使用git branch --set-upstream branch-name origin/branch-name；

- 从远程抓取分支，使用git pull，如果有冲突，要先处理冲突。

- 获取到服务器上的分支列表：git ls-remote --heads origin
##标签管理
tag就是一个让人容易记住的有意义的名字，它跟某个commit绑在一起。
##1. 创建标签
在Git中打标签非常简单，首先，切换到需要打标签的分支上：
```
$ git branch
* dev
  master
$ git checkout master
Switched to branch 'master'
```
然后，敲命令git tag <name>就可以打一个新标签：
```
$ git tag v1.0
```
可以用命令git tag查看所有标签：
```
$ git tag
v1.0
```
默认标签是打在最新提交的commit上的。有时候，如果忘了打标签，比如，现在已经是周五了，但应该在周一打的标签没有打，怎么办？

方法是找到历史提交的commit id，然后打上就可以了：
```
$ git log --pretty=oneline --abbrev-commit
6a5819e merged bug fix 101
cc17032 fix bug 101
7825a50 merge with no-ff
6224937 add merge
59bc1cb conflict fixed
400b400 & simple
75a857c AND simple
fec145a branch test
d17efd8 remove test.txt
...
```
比方说要对add merge这次提交打标签，它对应的commit id是6224937，敲入命令：
```
$ git tag v0.9 6224937
```
再用命令git tag查看标签：
```
$ git tag
v0.9
v1.0
```
注意，标签不是按时间顺序列出，而是按字母排序的。可以用git show <tagname>查看标签信息：
```
$ git show v0.9
commit 622493706ab447b6bb37e4e2a2f276a20fed2ab4
Author: Michael Liao <askxuefeng@gmail.com>
Date:   Thu Aug 22 11:22:08 2013 +0800

    add merge
...
```
可以看到，v0.9确实打在add merge这次提交上。

还可以创建带有说明的标签，用-a指定标签名，-m指定说明文字：
```
$ git tag -a v0.1 -m "version 0.1 released" 3628164
用命令git show <tagname>可以看到说明文字：

$ git show v0.1
tag v0.1
Tagger: Michael Liao <askxuefeng@gmail.com>
Date:   Mon Aug 26 07:28:11 2013 +0800

version 0.1 released

commit 3628164fb26d48395383f8f31179f24e0882e1e0
Author: Michael Liao <askxuefeng@gmail.com>
Date:   Tue Aug 20 15:11:49 2013 +0800

    append GPL
```
还可以通过-s用私钥签名一个标签：
```
$ git tag -s v0.2 -m "signed version 0.2 released" fec145a
```
签名采用PGP签名，因此，必须首先安装gpg（GnuPG），如果没有找到gpg，或者没有gpg密钥对，就会报错：
```
gpg: signing failed: secret key not available
error: gpg failed to sign the data
error: unable to sign the tag
```
如果报错，请参考GnuPG帮助文档配置Key。

用命令git show <tagname>可以看到PGP签名信息：
```
$ git show v0.2
tag v0.2
Tagger: Michael Liao <askxuefeng@gmail.com>
Date:   Mon Aug 26 07:28:33 2013 +0800

signed version 0.2 released
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (Darwin)

iQEcBAABAgAGBQJSGpMhAAoJEPUxHyDAhBpT4QQIAKeHfR3bo...
-----END PGP SIGNATURE-----

commit fec145accd63cdc9ed95a2f557ea0658a2a6537f
Author: Michael Liao <askxuefeng@gmail.com>
Date:   Thu Aug 22 10:37:30 2013 +0800

    branch test
```
用PGP签名的标签是不可伪造的，因为可以验证PGP签名。验证签名的方法比较复杂，这里就不介绍了。
####小结

- 命令git tag <name>用于新建一个标签，默认为HEAD，也可以指定一个commit id；

- git tag -a <tagname> -m "blablabla..."可以指定标签信息；

- git tag -s <tagname> -m "blablabla..."可以用PGP签名标签；

- 命令git tag可以查看所有标签。
###2. 操作标签
如果标签打错了，也可以删除：
```
$ git tag -d v0.1
Deleted tag 'v0.1' (was e078af9)
```
因为创建的标签都只存储在本地，不会自动推送到远程。所以，打错的标签可以在本地安全删除。

如果要推送某个标签到远程，使用命令git push origin <tagname>：
```
$ git push origin v1.0
Total 0 (delta 0), reused 0 (delta 0)
To git@github.com:michaelliao/learngit.git
 * [new tag]         v1.0 -> v1.0
```
或者，一次性推送全部尚未推送到远程的本地标签：
```
$ git push origin --tags
Counting objects: 1, done.
Writing objects: 100% (1/1), 554 bytes, done.
Total 1 (delta 0), reused 0 (delta 0)
To git@github.com:michaelliao/learngit.git
 * [new tag]         v0.2 -> v0.2
 * [new tag]         v0.9 -> v0.9
```
如果标签已经推送到远程，要删除远程标签就麻烦一点，先从本地删除：
```
$ git tag -d v0.9
Deleted tag 'v0.9' (was 6224937)
```
然后，从远程删除。删除命令也是push，但是格式如下：
```
$ git push origin :refs/tags/v0.9
To git@github.com:michaelliao/learngit.git
 - [deleted]         v0.9
```
要看看是否真的从远程库删除了标签，可以登陆GitHub查看。
####小结

- 命令git push origin <tagname>可以推送一个本地标签；

- 命令git push origin --tags可以推送全部未推送过的本地标签；

- 命令git tag -d <tagname>可以删除一个本地标签；

- 命令git push origin :refs/tags/<tagname>可以删除一个远程标签。
##使用github
- 在GitHub上，可以任意Fork开源仓库；

- 自己拥有Fork后的仓库的读写权限；

- 可以推送pull request给官方仓库来贡献代码。
##自定义Git
在安装Git一节中，我们已经配置了user.name和user.email，实际上，Git还有很多可配置项。

比如，让Git显示颜色，会让命令输出看起来更醒目：

	$ git config --global color.ui true
###1. 忽略特殊文件
有些时候，你必须把某些文件放到Git工作目录中，但又不能提交它们，比如保存了数据库密码的配置文件啦，等等，每次git status都会显示Untracked files ...，有强迫症的童鞋心里肯定不爽。

好在Git考虑到了大家的感受，这个问题解决起来也很简单，在Git工作区的根目录下创建一个特殊的.gitignore文件，然后把要忽略的文件名填进去，Git就会自动忽略这些文件。

不需要从头写.gitignore文件，GitHub已经为我们准备了各种配置文件，只需要组合一下就可以使用了。所有配置文件可以直接在线浏览：https://github.com/github/gitignore

忽略文件的原则是：

- 忽略操作系统自动生成的文件，比如缩略图等；
- 忽略编译生成的中间文件、可执行文件等，也就是如果一个文件是通过另一个文件自动生成的，那自动生成的文件就没必要放进版本库，比如Java编译产生的.class文件；
- 忽略你自己的带有敏感信息的配置文件，比如存放口令的配置文件。

最后一步就是把.gitignore也提交到Git，就完成了！当然检验.gitignore的标准是git status命令是不是说working directory clean。
有些时候，你想添加一个文件到Git，但发现添加不了，原因是这个文件被.gitignore忽略了：
```
$ git add App.class
The following paths are ignored by one of your .gitignore files:
App.class
Use -f if you really want to add them.
```
如果你确实想添加该文件，可以用-f强制添加到Git：
	$ git add -f App.class
或者你发现，可能是.gitignore写得有问题，需要找出来到底哪个规则写错了，可以用git check-ignore命令检查：
```
$ git check-ignore -v App.class
.gitignore:3:*.class    App.class
```
Git会告诉我们，.gitignore的第3行规则忽略了该文件，于是我们就可以知道应该修订哪个规则。
###2. 配置别名

有没有经常敲错命令？比如git status？status这个单词真心不好记。

如果敲git st就表示git status那就简单多了，当然这种偷懒的办法我们是极力赞成的。

我们只需要敲一行命令，告诉Git，以后st就表示status：

	$ git config --global alias.st status
好了，现在敲git st看看效果。

当然还有别的命令可以简写，很多人都用co表示checkout，ci表示commit，br表示branch：
```
$ git config --global alias.co checkout
$ git config --global alias.ci commit
$ git config --global alias.br branch
```
以后提交就可以简写成：

	$ git ci -m "bala bala bala..."
--global参数是全局参数，也就是这些命令在这台电脑的所有Git仓库下都有用。

在撤销修改一节中，我们知道，命令git reset HEAD file可以把暂存区的修改撤销掉（unstage），重新放回工作区。既然是一个unstage操作，就可以配置一个unstage别名：

	$ git config --global alias.unstage 'reset HEAD'
当你敲入命令：

	$ git unstage test.py
实际上Git执行的是：

	$ git reset HEAD test.py
配置一个git last，让其显示最后一次提交信息：

	$ git config --global alias.last 'log -1'
这样，用git last就能显示最近一次的提交：
```
$ git last
commit adca45d317e6d8a4b23f9811c3d7b7f0f180bfe2
Merge: bd6ae48 291bea8
Author: Michael Liao <askxuefeng@gmail.com>
Date:   Thu Aug 22 22:49:22 2013 +0800

    merge & fix hello.py
```
甚至还有人丧心病狂地把lg配置成了：
```
git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
```


配置文件

配置Git的时候，加上--global是针对当前用户起作用的，如果不加，那只针对当前的仓库起作用。

配置文件放哪了？每个仓库的Git配置文件都放在.git/config文件中：
```
$ cat .git/config 
[core]
    repositoryformatversion = 0
    filemode = true
    bare = false
    logallrefupdates = true
    ignorecase = true
    precomposeunicode = true
[remote "origin"]
    url = git@github.com:michaelliao/learngit.git
    fetch = +refs/heads/*:refs/remotes/origin/*
[branch "master"]
    remote = origin
    merge = refs/heads/master
[alias]
    last = log -1
```
别名就在[alias]后面，要删除别名，直接把对应的行删掉即可。

而当前用户的Git配置文件放在用户主目录下的一个隐藏文件.gitconfig中：
```
$ cat .gitconfig
[alias]
    co = checkout
    ci = commit
    br = branch
    st = status
[user]
    name = Your Name
    email = your@email.com
```
配置别名也可以直接修改这个文件，如果改错了，可以删掉文件重新通过命令配置。
##搭建Git服务器
这块暂时用不着，所以不详细记录笔记了。

星期三, 20. 七月 2016 02:38下午 

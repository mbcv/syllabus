##### git设置别名
-----
1. 创建一个文件  ~/.gitconfig

2. 在文件中写入如下
[alias]
    st = status
    ci = commit
    co = checkout
    br = branch
    unstage = reset HEAD --
    last = log -1 HEAD

##### git stash
`git stash`  备份工作区
`git stash list` 查看备份列表
`git stash pop` 取出最近一次保存的内容
`git stash apply stash@{1}` 去除指定位置的内容


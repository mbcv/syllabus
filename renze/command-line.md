### xargs使用
xargs是给命令传递参数的一个过滤器，也是组合多个命令的一个工具。
xargs从管道或者stdin中读取数据，但是它也能够从文件的输出中读取数据。
捕获一个命令的输出，然后传递给另外一个命令

`-e flag` ，注意有的时候可能会是-E，flag必须是一个以空格分隔的标志，当xargs分析到含有flag这个标志的时候就停止。
`-n num` 后面加次数，表示命令在执行的时候一次用的argument的个数，默认是用所有的。
`-p` 操作具有可交互性，每次执行comand都交互式提示用户选择，当每次执行一个argument的时候询问一次用户
`-t` 表示先打印命令，然后再执行。

例：
> cat 1.txt 
aaa bbb aaa ddd
ee	ff

> cat 1.txt | xargs -n 2
aaa bbb
aaa ddd
ee ff

> cat 1.txt | xargs -E ddd
aaa bbb aaa

-i 或者是-I，这得看linux支持了，将xargs的每项名称，一般是一行一行赋值给{}，可以用{}代替。

> $ ls
1.txt  2.txt  3.txt  log.xml
$ ls *.txt |xargs -t -i mv {} {}.bak
mv 1.txt 1.txt.bak 
mv 2.txt 2.txt.bak 
mv 3.txt 3.txt.bak

`-r`  no-run-if-empty 如果没有要处理的参数传递给xargsxargs 默认是带 空参数运行一次，如果你希望无参数时，停止 xargs，直接退出，使用 -r 选项即可，其可以防止xargs 后面命令带空参数运行报错。 
`-s` num xargs后面那个命令的最大命令行字符数(含空格) 

`-P` 修改最大的进程数，默认是1，为0时候为as many as it can 。

`-0` 当sdtin含有特殊字元时候，将其当成一般字符，像/'空格等

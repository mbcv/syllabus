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

---

### other

使用 ag 在源代码或数据文件里检索（比 grep -r 更好）

Excel 或 CSV 文件的处理: [csvkit](http://csvkit.readthedocs.io/en/0.9.1/tutorial/1_getting_started.html)

[cut & paste & join & tr](http://blog.csdn.net/carolzhang8406/article/details/6112045)

wc - print newline, word, and byte counts for each file

tee - read from standard input and write to standard output and files

[diff and batch](http://www.cnblogs.com/cute/archive/2011/04/29/2033011.html)

web调试 [httpie](https://github.com/jkbrzt/httpie)

使用 iostat、netstat、top （htop 更佳）和 dstat 去获取硬盘、cpu 和网络的状态。

使用 netstat 和 ss 查看网络连接的细节。

[glances](https://github.com/nicolargo/glances)

使用 grep . *（每行都会附上文件名）或者 head -100 *（每个文件有一个标题）来阅读检查目录下所有文件的内容。

计算文本文件第三列中所有数的和（可能比同等作用的 Python 代码快三倍且代码量少三倍）：
`awk '{ x += $3 } END { print x }' myfile`



### 冷门但有用

* `expr`：计算表达式或正则匹配

* `m4`：简单地宏处理器

* `yes`：多次打印字符串

* `cal`：漂亮的日历
* `env`：执行一个命令（脚本文件中很有用）
* `printenv`：打印环境变量（调试时或在使用脚本文件时很有用）

* `look`：查找以特定字符串开头的单词

* `cut、paste 和 join`：数据修改

* `fmt`：格式化文本段落

* `pr`：将文本格式化成页/列形式

* `fold`：包裹文本中的几行

* `column`：将文本格式化成多列或表格

* `expand` 和 `unexpand`：制表符与空格之间转换

* `nl`：添加行号

* `seq`：打印数字

* `bc`：计算器

* `factor`：分解因数

* `gpg`：加密并签名文件

* `toe`：terminfo entries 列表

* `nc`：网络调试及数据传输

* `socat`：套接字代理，与 netcat 类似

* `slurm`：网络可视化

* `dd`：文件或设备间传输数据

* `file`：确定文件类型

* `tree`：以树的形式显示路径和文件，类似于递归的 ls

stat：文件信息

time：执行命令，并计算执行时间

timeout：在指定时长范围内执行命令，并在规定时间结束后停止进程

lockfile：使文件只能通过 rm -f 移除

logrotate： 切换、压缩以及发送日志文件

watch：重复运行同一个命令，展示结果并高亮有更改的部分

tac：反向输出文件

shuf：文件中随机选取几行

comm：一行一行的比较排序过的文件

pv：监视通过管道的数据

hd，hexdump，xxd，biew 和 bvi：保存或编辑二进制文件

strings：从二进制文件中抽取文本

tr：转换字母

iconv 或 uconv：简易的文件编码

split 和 csplit：分割文件

sponge：在写入前读取所有输入，在读取文件后再向同一文件写入时比较有用，例如 grep -v something some-file | sponge some-file

units：将一种计量单位转换为另一种等效的计量单位（参阅 /usr/share/units/definitions.units）

apg：随机生成密码

7z：高比例的文件压缩

ldd：动态库信息

nm：提取 obj 文件中的符号

ab：性能分析 web 服务器

strace：系统调用调试

mtr：更好的网络调试跟踪工具

cssh：可视化的并发 shell

rsync：通过 ssh 或本地文件系统同步文件和文件夹

wireshark 和 tshark：抓包和网络调试工具

ngrep：网络层的 grep

host 和 dig：DNS 查找

lsof：列出当前系统打开文件的工具以及查看端口信息

dstat：系统状态查看

glances：高层次的多子系统总览

iostat：硬盘使用状态

mpstat： CPU 使用状态

vmstat： 内存使用状态

htop：top 的加强版

last：登入记录

w：查看处于登录状态的用户

id：用户/组 ID 信息

sar：系统历史数据

iftop 或 nethogs：套接字及进程的网络利用

ss：套接字数据

dmesg：引导及系统错误信息

sysctl： 在内核运行时动态地查看和修改内核的运行参数

hdparm：SATA/ATA 磁盘更改及性能分析

lsblk：列出块设备信息：以树形展示你的磁盘以及磁盘分区信息

lshw，lscpu，lspci，lsusb 和 dmidecode：查看硬件信息，包括 CPU、BIOS、RAID、显卡、USB设备等

lsmod 和 modinfo：列出内核模块，并显示其细节

fortune，ddate 和 sl：额，这主要取决于你是否认为蒸汽火车和莫名其妙的名人名言是否“有用”

expr：计算表达式或正则匹配

m4：简单地宏处理器

yes：多次打印字符串

cal：漂亮的日历

env：执行一个命令（脚本文件中很有用）

printenv：打印环境变量（调试时或在使用脚本文件时很有用）

look：查找以特定字符串开头的单词

cut、paste 和 join：数据修改

fmt：格式化文本段落

pr：将文本格式化成页/列形式

fold：包裹文本中的几行

column：将文本格式化成多列或表格

expand 和 unexpand：制表符与空格之间转换

nl：添加行号

seq：打印数字

bc：计算器

factor：分解因数

gpg：加密并签名文件

toe：terminfo entries 列表

nc：网络调试及数据传输

socat：套接字代理，与 netcat 类似

slurm：网络可视化

dd：文件或设备间传输数据

file：确定文件类型

tree：以树的形式显示路径和文件，类似于递归的 ls

stat：文件信息

time：执行命令，并计算执行时间

timeout：在指定时长范围内执行命令，并在规定时间结束后停止进程

lockfile：使文件只能通过 rm -f 移除

logrotate： 切换、压缩以及发送日志文件

watch：重复运行同一个命令，展示结果并高亮有更改的部分

tac：反向输出文件

shuf：文件中随机选取几行

comm：一行一行的比较排序过的文件

pv：监视通过管道的数据

hd，hexdump，xxd，biew 和 bvi：保存或编辑二进制文件

strings：从二进制文件中抽取文本

tr：转换字母

iconv 或 uconv：简易的文件编码

split 和 csplit：分割文件

sponge：在写入前读取所有输入，在读取文件后再向同一文件写入时比较有用，例如 grep -v something some-file | sponge some-file

units：将一种计量单位转换为另一种等效的计量单位（参阅 /usr/share/units/definitions.units）

apg：随机生成密码

7z：高比例的文件压缩

ldd：动态库信息

nm：提取 obj 文件中的符号

ab：性能分析 web 服务器

strace：系统调用调试

mtr：更好的网络调试跟踪工具

cssh：可视化的并发 shell

rsync：通过 ssh 或本地文件系统同步文件和文件夹

wireshark 和 tshark：抓包和网络调试工具

ngrep：网络层的 grep

host 和 dig：DNS 查找

lsof：列出当前系统打开文件的工具以及查看端口信息

dstat：系统状态查看

glances：高层次的多子系统总览

iostat：硬盘使用状态

mpstat： CPU 使用状态

vmstat： 内存使用状态

htop：top 的加强版

last：登入记录

w：查看处于登录状态的用户

id：用户/组 ID 信息

sar：系统历史数据

iftop 或 nethogs：套接字及进程的网络利用

ss：套接字数据

dmesg：引导及系统错误信息

sysctl： 在内核运行时动态地查看和修改内核的运行参数

hdparm：SATA/ATA 磁盘更改及性能分析

lsblk：列出块设备信息：以树形展示你的磁盘以及磁盘分区信息

lshw，lscpu，lspci，lsusb 和 dmidecode：查看硬件信息，包括 CPU、BIOS、RAID、显卡、USB设备等

lsmod 和 modinfo：列出内核模块，并显示其细节

fortune，ddate 和 sl：额，这主要取决于你是否认为蒸汽火车和莫名其妙的名人名言是否“有用”





csvkit
--

打开并且查看excel格式的文件
`in2csv  data.xlsx`
把xls，xlsx文件转换成固定宽度的csv文件
`in2csv  data.xlsx > data.csv`

查看csv文件: `csvlook data.csv`
仅查看列名: `csvcut -n data.csv`
仅查看第2,5,6列的内容: `csvcut -c 2,5,6 data.csv`
也可以直接用*列名*来查看: 
`csvcut -c county,item_name,quantity data.csv`

csvcut与csvlook一起使用
`csvcut -c county,item_name,quantity data.csv | csvlook | head`
也可以直接使用in2csv
`in2csv ne_1033_data.xlsx | csvcut -c county,item_name,quantity | csvlook | head`

查找数据：csvgrep
`csvcut -c county,item_name,total_cost data.csv | csvgrep -c county -m LANCASTER | csvlook`

`-m`意思是匹配，也可以用`-r`来查找正则表达式

排序
`csvcut -c county,item_name,total_cost data.csv | csvgrep -c county -m LANCASTER | csvsort -c total_cost -r | csvlook`
根据total_cost排序 `-r`代表reverse  倒序

合并两个文件 csvjoin
`csvjoin -c fips data.csv acs2012_5yr_population.csv > joined.csv`
根据fips列合并两个文件

许多大的数据集经常被存储在许多个小文件中，如果想要把他们合并在一起
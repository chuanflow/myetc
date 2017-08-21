#!/bin/bash

# 排序并去重
# 比较相邻行
filename=$0
echo $filename
uniq -c $filename
# 全文本去重
sort -u $filename
# 保证原来顺序去重
awk '!tmp[$0]++' $filename

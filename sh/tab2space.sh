#!/bin/bash
#将参数$1文件夹下所有的文件中的tab换为4个空格
function tab2space(){
    for file in $1/*
    do
        if [ -d $file ]
        then
            tab2space $file
        elif [ -f $file ]
        then
            sed -i 's/\t/    /g' $file
        fi
    done
}
tab2space $1

#!/bin/bash
#用于为原生的markdown或html文件加上jekyll标记
function 4jekyll(){
    for file in $1/*
    do
        if [ -d $file ]
        then
            4jekyll $file
        elif [ -f $file ]
        then
            if [ "${file##*.}" == "md" -o "${file##*.}" == "html" ]    
            then
                nameall=${file##*/}
                name=${nameall%%.*}
                if [ ! $file -ef $2/$nameall ]
                then
                    cp  -u $file $2/$nameall
                fi
                file=$2/$nameall
                if [[ $name =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}.*$ ]]
                then
                    #在文件第一行前添加内容
                    if [ "`head -n 1 $file`" != "---"  ]
                    then
                        sed -i '1i---\nlayout: post\ntitle: '"$name"'\ncategories:\n- past\ntags:\n- past\n---' $file
                    #else
                    ##从第一行开始删除八行
                    #
                    #sed -i '1,8d' $file
                    fi
                    echo $nameall
                else
                    #在文件第一行前添加内容
                    if [ "`head -n 1 $file`" != "---" ]
                    then
                        sed -i '1i---\nlayout: post\ntitle: '"$name"'\ncategories:\n- past\ntags:\n- past\n---' $file
                    fi
                    #复制到参数2路径下
                    month_day=$(printf "%02d-%02d" $(($RANDOM%12+1)) $(($RANDOM%27+1)))
                    echo $month_day
                    mv $file $2/2016-$month_day-$nameall
                fi
            fi
        fi
    done
}
4jekyll $1 $2

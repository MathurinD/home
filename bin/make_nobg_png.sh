#! /bin/bash
#-*- coding:utf8 -*-

for file in `ls *.png`
do
    if [[ ! $file =~ "_nobg-" ]]
    then
        new_file=$(echo $file | sed "s/\(-[0-9].png\)/_nobg\1/")
        if [[ $file =~ "0.png" ]]
        then
            convert $file -negate -edge 1 -negate -colorspace Gray $new_file 
        else
            convert $file -negate -edge 1 -negate $new_file 
        fi
    fi
done

#!/usr/bin/env zsh

# 定义要搜索的词汇
search_word="跨性别"
input_liens=$1

N=0

while read -r line
do
    N=$( expr $N + 1 )

    # 获取包含指定词汇的上下文
    grep -C 2 "$search_word" "./../dumps-text/ch/fich${N}-ch.txt" > "./../contextes/ch/fich${N}-ch.txt"

done < $input_liens

#!/usr/bin/env zsh

# 定义要搜索的词汇
search_word="transgenre"
input_liens=$1

N=0

while read -r line
do
    N=$( expr $N + 1 )

    # 获取包含指定词汇的上下文
    # 这里我们使用了 -o 和 -P 选项，并且调整了正则表达式来匹配前后5-6个词语
    grep -o -P "(\w+\W){0,5}${search_word}(\W\w+){0,5}" "./../contextes/fr/fr-${N}.txt" > "./../concordance/fr-${N}.txt"

done < $input_liens

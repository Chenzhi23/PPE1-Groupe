#!/usr/bin/env zsh

# 定义要搜索的词汇
search_word="跨性别"
input_liens=$1

N=0

while read -r line
do
    N=$( expr $N + 1 )


   export LANG=zh_CN.UTF-8
   grep -P -o "([\p{Han}]{0,5}[^\p{Han}]*?)($search_word)([^\p{Han}]*?[\p{Han}]{0,5})"  "./../contextes/ch/ch-${N}.txt" | LANG=C sed -E -r "s/(.*)(跨性别)(.*)/<tr><td>\1<\/td><td>\2<\/td><td>\3<\/td><\/tr>/" >> "../concordance/ch/ch-$N.html"



done < $input_liens

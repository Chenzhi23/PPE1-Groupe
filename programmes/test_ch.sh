#!/usr/bin/env bash


search_word="跨性别"
file=$1

# 检查文件是否存在
if [ ! -f "$file" ]
then
    echo "Le fichier spécifié n'existe pas."
    exit 1
fi

echo "<html>
 <head><title>Tableau</title><meta charset='UTF-8' /></head>
 <body>
 <table border='1'>
 <tr><th>N°</th><th>URL</th><th>Code HTTP</th><th>encoding</th><th>Aspirations</th><th>Dump text</th><th>compte</th><th>contextes</th></tr>" > tableau-ch.html

N=1

while read -r line
do
    # 使用 curl 获取文本内容
    curl -o "dump${N}.txt" -s "${line}"

    # 计算词汇出现的次数, -o，它仅输出匹配模式本身的部分
    count=$(grep -o "$search_word" "dump${N}.txt" | wc -l) 
    rm "dump${N}.txt"


    http_response=$(curl -I -s "${line}")
    # -I 选项表示只获取 HTTP 响应头  -s 选项使 curl 在执行时不显示任何输出（静默模式）
    http_code=$(echo "$http_response" | grep -oE 'HTTP/[0-9.]+\s[0-9]+' | awk '{print $2}')

    encoding=$(echo "$http_response" | grep -i 'Content-Type' | grep -oP 'charset=\K([-A-Za-z0-9]+)')

    if [ -z "$encoding" ]
    then
        encoding="N/A"
    fi

    echo "<tr><td>${N}</td><td>${line}</td><td>${http_code}</td><td>${encoding}</td><td><a href='./../aspirations/ch/fich${N}-ch.html'>Aspiration${N}</a></td><td><a href='./../dumps-text/ch/fich${N}-ch.txt'>Dump${N}</a></td><td>${count}</td><td><a href='./../contextes/ch/fich${N}-ch.txt'>Contexte${N}</a></td></tr>" >> tableau-ch.html

    N=$(expr $N + 1)
done < "$file"

echo "</table></body></html>" >> tableau-ch.html

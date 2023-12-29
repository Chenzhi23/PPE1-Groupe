#!/usr/bin/env bash

input_liens=$1
search_word="跨性别"
output_file="./../concordance/ch-${N}.html"

echo "<!DOCTYPE html>
<html lang=\"zh\">
<head>
    <!-- Metadata -->
    <meta charset=\"UTF-8\"/>
    <title>Tableaux- PPE1 Projet Groupe</title>
    <!-- Bootstrap and custom CSS -->
    <!-- ... -->
</head>
<body>
<div class=\"container\">
    <br/>
    <table class=\"table table-striped-columns\">
        <thead>
          <tr>
            <th scope=\"col\">Gauche</th>
            <th scope=\"col\">Mot</th>
            <th scope=\"col\">Droite</th>
          </tr>
        </thead>" > $output_file

N=0

while read -r line
do
    N=$( expr $N + 1 )

    # 下载网页内容到临时文件
    temp_file="./temp_${N}.html"
    curl "$line" > "$temp_file"

    # 获取包含指定词汇的上下文
    grep -o -P "([\p{Han}]{0,5}[^\p{Han}]*?)${search_word}([^\p{Han}]*?[\p{Han}]{0,5})" "$temp_file" | sed "s/\(${search_word}\)/<td>\1<\/td>/g" >> $output_file

    # 删除临时文件
    rm "$temp_file"
done < $input_liens

echo "      </table>
        </div>
</body>
</html>" >> $output_file

#!/usr/bin/env zsh




input_liens=$1

lang=$(basename $1 .txt)



# le choix de langue
# 定义要搜索的词汇
if [ $lang = "fr" ]; 
then
	cible="(T|t)ransgenres?"
fi
 
if [ $lang = "en" ]; 
then
	cible="transgender"
fi

if [ $lang = "ch" ]; 
then
	cible="跨性别"
fi

if [ $lang = "jp" ]; 
then
	cible="トランスジェンダー"
fi

N=0

while read -r line
do
    N=$( expr $N + 1 )
    chemin=./../concordance/$lang/$lang-$N.html

    echo "<html>
    <head>
        <meta charset="UTF-8">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@0.9.4/css/bulma.min.css">
        <style>
            .table-container {
                max-width: 1000px;
                margin: 0 auto;
            }
            .has-background-rose {
                background-color: #FFE7FE;
            }
        </style>
    </head>" > $chemin


    echo "<body>
    <div class="container">
        <br/>
        <table class=\"table table-striped-columns\">
            <thead>
            <tr>
                <th scope="col">Gauche</th>
                <th scope="col">Mot</th>
                <th scope="col">Droite</th>
            </tr>
            </thead>" >> $chemin


    # 获取包含指定词汇的上下文
    # 这里我们使用了 -o 和 -P 选项，并且调整了正则表达式来匹配前后5-6个词语
    ggrep -o -P "((\w+\W){0,5})(${cible})((\W\w+){0,5})" ./../contextes/$lang/$lang-${N}.txt | sed -E "s/(.*)($cible)(.*)/<tr><td>\1<\/td><td>\2<\/td><td>\3<\/td><\/tr>/"  >> $chemin
   
done < $input_liens

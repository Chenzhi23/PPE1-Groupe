#!/usr/bin/env zsh



search_word="跨性别"
input_liens=$1

N=0

while read -r line
do
    N=$( expr $N + 1 )

    chemin=../concordance/ch/ch-$N.html

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

   export LANG=zh_CN.UTF-8
   grep -P -o "([\p{Han}]{0,5}[^\p{Han}]*?)($search_word)([^\p{Han}]*?[\p{Han}]{0,5})"  "./../contextes/ch/ch-${N}.txt" | LANG=C sed -E -r "s/(.*)(跨性别)(.*)/<tr><td>\1<\/td><td>\2<\/td><td>\3<\/td><\/tr>/" >> $chemin



done < $input_liens

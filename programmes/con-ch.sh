#!/usr/bin/env zsh

input_liens=$1
lang=$(basename $1 .txt)

# Define the target word based on language
if [ $lang = "en" ]; then
    cible="transgender"
elif [ $lang = "fr" ]; then
    cible="(T|t)ransgenres?"
elif [ $lang = "ch" ]; then
    cible="跨性别"
elif [ $lang = "jp" ]; then
    cible="トランスジェンダー"
fi

N=0

while read -r line
do
    N=$( expr $N + 1 )
    chemin=./../concordance/$lang/$lang-$N.html

    # Start of HTML file
    echo "<html>
    <head>
        <meta charset=\"UTF-8\">
        <link rel=\"stylesheet\" href=\"https://cdn.jsdelivr.net/npm/bulma@0.9.4/css/bulma.min.css\">
        <style>
            .table-container {
                max-width: 1000px;
                margin: 0 auto;
            }
            .has-background-rose {
                background-color: #FFE7FE;
            }
        </style>
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
            </thead>
            <tbody>" > $chemin

    # Apply different commands based on language
    if [ $lang = "en" ]; then
        # Use ggrep for English
        ggrep -o -P "((\w+\W){0,5})(${cible})((\W\w+){0,5})" ./../contextes/en/en-$N.txt | sed -E "s/(.*)($cible)(.*)/<tr><td>\1<\/td><td>\2<\/td><td>\3<\/td><\/tr>/"  >> $chemin
    elif [ $lang = "fr" ]; then
        # Use ggrep for French
        ggrep -o -P "((\w+\W){0,5})(${cible})((\W\w+){0,5})" ./../contextes/fr/fr-$N.txt | sed -E "s/(.*)($cible)(.*)/<tr><td>\1<\/td><td>\2<\/td><td>\3<\/td><\/tr>/"  >> $chemin
    elif [ $lang = "ch" ]; then
        # Use grep for Chinese
        export LANG=zh_CN.UTF-8
        ggrep -P -o "([\p{Han}]{0,5}[^\p{Han}]*?)(${cible})([^\p{Han}]*?[\p{Han}]{0,5})"  "./../contextes/ch/ch-$N.txt" | LANG=C sed -E -r "s/(.*)($cible)(.*)/<tr><td>\1<\/td><td>\2<\/td><td>\3<\/td><\/tr>/" >> $chemin
    elif [ $lang = "jp" ]; then
        # Use grep for Japanese
        export LANG=ja_JP.UTF-8
        ggrep -P -o "([\p{Han}]{0,5}[^\p{Han}]*?)(${cible})([^\p{Han}]*?[\p{Han}]{0,5})"  "./../contextes/jp/jp-$N.txt" | LANG=C sed -E -r "s/(.*)($cible)(.*)/<tr><td>\1<\/td><td>\2<\/td><td>\3<\/td><\/tr>/" >> $chemin
    fi

    # End of HTML file
    echo "</tbody>
        </table>
    </div>
    </body>
    </html>" >> $chemin

done < $input_liens

#!/usr/bin/env zsh



if [ $# -ne 1 ]
then 
    echo "ce programme demande un argument"
fi

###chemin=$(./../tableaux/tableau-fr.html)
lang=$(basename $1 .txt)
chemin=./../tableaux/$lang.html
###echo "<html>" > $chemin   行得通
## chemin="./../tableaux/tableau-fr.html" 加不加双引号都行
## 也可以把 chemin 变成argument (chemin=$2)


## 可以 echo "
#               "
echo "<html>
<head>
<meta charset="UTF-8"/>" > $chemin
### 或者"<meta charset=\"UTF-8\">"

echo "</head>
<body>
<table>
<tr><th>Ligne</th><th>URL</th><th>Code HTTP</th><th>Encodage</th><th>Compte</th><th>Contexte</th><th>Aspirations</th><th>Dump</th></tr>" >> $chemin

fichier_urls=$1
ligne=0
while read -r line
### 为什么最后一行不被read啊？
do
    ligne=$( expr $ligne + 1 )
    code=$(curl -s -I -L -w  "%{http_code}" -o /dev/null $line)
    charset=$(curl -s -I -L -w  "%{content_type}" -o /dev/null $line ｜ ggrep -P -o "charset=\S+" | cut -d"=" -f2 | tail -n 1)
    ###################################################################我的mac`grep -P`行不通的，至于为什么此处结果正确，因为删掉`-P`也可以
    compte=$(cat ./../dumps-text/fr/fr-$ligne.txt | ggrep -o -P "(T|t)ransgenres?" | wc -l)
    echo "<tr>
    <td>$ligne</td><td>$line</td><td>$code</td><td>$charset</td><td>$compte</td><td><a href="./../contextes/fr/fr-$ligne.txt">Contexte$ligne</a></td><td><a href="./../aspirations/fr/fr-$ligne.html">Aspiration$ligne</a></td><td><a href="./../dumps-text/fr/fr-$ligne.txt">Dump$ligne</a></td>
    </tr>" >> $chemin

done < $fichier_urls

#### 其实相当于
### cat $fichier_urls | while read line      # cat 命令的输出作为read命令的输入,read读到>的值放在line中


echo "</table>
</body>
</html>" >> $chemin
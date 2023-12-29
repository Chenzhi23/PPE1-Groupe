#!/usr/bin/env bash

counter=1
urlfile=../urls/japonais.txt


echo "<html>
	<head>
		<meta charset="UTF-8"/>
	</head>
	<body>
		<table border="black solid">
			<tr><th>link number</th><th>url</th><th>HTTP status</th><th>charset</th><th>compte</th><th>lien d'aspiration</th><th>lien des dumps</th><th>lien de contexte</th></tr>" > ../tableaux/tableau-jp.html


while read -r line;
do
	if [ -n "$line" ];
	then
		echo "en traitement de l'url numéro $counter"
		lang=$(basename $urlfile .txt)
		code=$(curl -I -L -s -w "%{http_code}" -o /dev/null $line)
		charset=$(curl -I -s -w "%{content_type}" -o /dev/null $line | grep -E -o "charset=[^[:space:]]+" | cut -d "=" -f2)

		# aspirations
		curl -L $line > ../aspirations/jp/fich-$lang-$counter.html
		# dump text
		lynx --dump --nolist $line > ../dumps-text/jp/fich-$lang-$counter.txt
		# occurence de mot étudié
		occurence=$(lynx --nolist --dump $line | grep -i トランスジェンダー | wc -l)
		# récupérer les contextes
		lynx --nolist --dump $line | grep -i -B 1 -A 1 "トランスジェンダー" > ../contextes/jp/fich-$lang-$counter.txt
		# remplie le tableau
		echo -e "\t\t\t<tr><td>$counter</td><td>$line</td><td>$code</td><td>$charset</td><td>$occurence</td><td><a href="../aspirations/fich-$lang-$counter.html">aspiration-$lang-$counter</a></td><td><a href="../dumps-text/fich-$lang-$counter.txt">dump-$lang-$counter</a></td><td><a href="../contextes/fich-$lang-$counter.txt">contexte-$lang-$counter</a></td></tr>" >> ../tableaux/tableau-jp.html
		counter=$(expr $counter + 1)
	fi
done < $urlfile


echo "		</table>
	</body>
</html>" >> ../tableaux/tableau-jp.html
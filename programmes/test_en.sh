#!/usr/bin/env bash

counter=1
urlfile=../urls/anglais.txt


echo "<html>
	<head>
		<meta charset="UTF-8"/>
	</head>
	<body>
		<table border="black solid">
			<tr><th>numéro_url</th><th>url</th><th>status_code</th><th>charset</th><th>compte</th>" > ../tableaux/tableau-en.html


while read -r line;
do
	if [ -n "$line" ];
	then
		echo "en traitement de l'url numéro $counter"
		lang=$(basename $urlfile .txt)
		code=$(curl -I -L -s -w "%{http_code}" -o /dev/null $line)
		charset=$(curl -I -s -w "%{content_type}" -o /dev/null $line | grep -P -o "charset=\S+" | cut -d "=" -f2)
		# aspirations
		curl $line > ../aspirations/fich-$lang-$counter.html
		# dump text
		lynx --dump --nolist $line > ../dumps-text/fich-$lang-$counter.txt
		# occurence de mot étudié
		occurence=$(lynx --nolist --dump $line | grep -i transgender | wc -l)
		# récupérer les contextes
		lynx --nolist --dump $line | grep -i -B 1 -A 1 "transgender" > ../contextes/fich-$lang-$counter.txt
		# remplie le tableau
		echo -e "\t\t\t<tr><td>$counter</td><td>$line</td><td>$code</td><td>$charset</td><td>$occurence</td></tr>" >> ../tableaux/tableau-en.html
		counter=$(expr $counter + 1)
	fi
done < $urlfile


echo "		</table>
	</body>
</html>" >> ../tableaux/tableau-en.html
#!/usr/bin/env bash

counter=1
urlfile=../urls/en.txt


echo "<html>
	<head>
		<meta charset="UTF-8"/>
	</head>
	<body>
		<table border="black solid">
			<tr><th>numéro d'url</th><th>url</th><th>code de status</th><th>charset</th><th>compte</th><th>lien d'aspiration</th><th>lien des dumps</th><th>lien de contexte</th></tr>" > ../tableaux/tableau-en.html


while read -r line;
do
	if [ -n "$line" ];
	then		if [ ! $charset == "UTF-8" ];
			then
				iconv -f "$charset" -t "UTF-8"
			fi
		echo "en traitement de l'url numéro $counter"
		lang=$(basename $urlfile .txt)
		code=$(curl -I -L -s -w "%{http_code}" -o /dev/null $line)
		charset=$(curl -I -s -w "%{content_type}" -o /dev/null $line | grep -P -o "charset=\S+" | cut -d "=" -f2)
		
		if [ $code == "200" ];
		then
			if [ ! $charset == "UTF-8" ];
			then
				iconv -f "$charset" -t "UTF-8" -o "../aspirations/en/en-$counter.html"
			fi
			# aspirations
			curl -L $line > ../aspirations/en/$lang-$counter.html
			# dump text
			lynx -assume_charset UTF-8 --dump --nolist $line > ../dumps-text/en/$lang-$counter.txt
			# occurence de mot étudié
			occurence=$(grep -i -o "transgender" ../dumps-text/en/$lang-$counter.txt| wc -l)
			# récupérer les contextes
			grep -i -B 1 -A 1 "transgender" ../dumps-text/en/$lang-$counter.txt > ../contextes/en/$lang-$counter.txt
			# concordances
			# grep -i -o -P "(\w+\s){0,5}transgender(\s\w+){0,5}" fich-anglais-3.txt | sed 's/\btransgender\b/\t&\t/g'
			# remplie le tableau
			echo -e "\t\t\t<tr><td>$counter</td><td>$line</td><td>$code</td><td>$charset</td><td>$occurence</td><td><a href="../aspirations/en/$lang-$counter.html">aspiration-$lang-$counter</a></td><td><a href="../dumps-text/en/$lang-$counter.txt">dump-$lang-$counter</a></td><td><a href="../contextes/en/$lang-$counter.txt">contexte-$lang-$counter</a></td></tr>" >> ../tableaux/tableau-en.html
			counter=$(expr $counter + 1)
		fi
	fi
done < $urlfile


echo "		</table>
	</body>
</html>" >> ../tableaux/tableau-en.html

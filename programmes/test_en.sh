#!/usr/bin/env bash
# taper "bash programme/miniprojet.sh urls/fr.txt" pour exécuter ce programme
counter=1
urlfile=$1

if [ $# -ne 1 ]
then
	echo "Un argument attendu exactement." # Si l'argument existe
	exit
else
	if [ -f $urlfile ] 
	then
		echo "on a bien un fichier"
	else
		echo "on attend un fichier qui existe"
		exit
	fi
fi


echo "<html>
	<head>
		<meta charset="UTF-8"/>
	</head>
	<body>
		<table border="black solid">
			<tr><th>numéro_url</th><th>url</th><th>status_code</th><th>charset</th>" > table_anglais.html


while read -r line;
do
	if [ -n "$line" ];
	then
		lang=$(basename $URLS .txt)
		code=$(curl -I -L -s -w "%{http_code}" -o /dev/null $line)
		charset=$(curl -I -s -w "%{content_type}" -o /dev/null $line | grep -P -o "charset=\S+" | cut -d "=" -f2)
		echo -e "\t\t\t<tr><td>$counter</td><td>$line</td><td>$code</td><td>$charset</td></tr>" >> table_anglais.html
		counter=$(expr $counter + 1)
	fi
done < $urlfile


echo "		</table>
	</body>
</html>" >> table_anglais.html
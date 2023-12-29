#!/usr/bin/env zsh


input_liens=$1

ligne=0
lang=$(basename $1 .txt)

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



while read -r line
do
    ligne=$( expr $ligne + 1 )
    cat ./../dumps-text/$lang/$lang-$ligne.txt | ggrep -P -a -A 2 -B 2 "$cible" > ./../contextes/$lang/$lang-$ligne.txt
done < $input_liens


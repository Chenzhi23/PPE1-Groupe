#!/usr/bin/env zsh


input_liens=$1

ligne=0

while read -r line
do
    ligne=$( expr $ligne + 1 )
    cat ./../dumps-text/fr/fich$ligne-fr.txt | ggrep -P -A 2 -B 2 "(T|t)ransgenres?" > ./../contextes/fr/fich$ligne-fr.txt
done < $input_liens


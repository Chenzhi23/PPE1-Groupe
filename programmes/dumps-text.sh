#!/usr/bin/env zsh


input_liens=$1

ligne=0

while read -r line
do
    ligne=$( expr $ligne + 1 )
    lynx -dump -nolist $line > ./../dumps-text/fr/fich$ligne-fr.txt
done < $input_liens


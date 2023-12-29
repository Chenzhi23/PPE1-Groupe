#!/usr/bin/env zsh


input_liens=$1

ligne=0
lang=$(basename $1 .txt)


while read -r line
do
    ligne=$( expr $ligne + 1 )
    
    if [ $lang = "fr" ]; 
    then
        lynx -dump -nolist $line > ./../dumps-text/$lang/$lang-$ligne.txt
    fi

    if [ $lang = "ch" ]; 
    then
        lynx -dump -nolist $line > ./../dumps-text/$lang/$lang-$ligne.txt
    fi

    if [ $lang = "jp" ]; 
    then
        w3m $line > ./../dumps-text/$lang/$lang-$ligne.txt
    fi

    if [ $lang = "ch" ]; 
    then
        w3m $line > ./../dumps-text/$lang/$lang-$ligne.txt
    fi

done < $input_liens


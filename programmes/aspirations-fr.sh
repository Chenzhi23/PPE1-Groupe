#!/usr/bin/env zsh


input_liens=$1

ligne=0

while read -r line
do
    ligne=$( expr $ligne + 1 )
    curl -o ./../aspirations/fr/fr-$ligne.html $line
done < $input_liens



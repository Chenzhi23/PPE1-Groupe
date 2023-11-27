#!/usr/bin/env bash

if [ $# -ne 1 ]
then
    echo "Ce script a besoin d'un argument: <URL>."
    exit 1
fi

URL="$1"
numero=0

while read -r line;
do
     numero=$( expr $numero + 1 )
     curl -o ./../aspirations/ch/fich${numero}-ch.html $line
done < $URL



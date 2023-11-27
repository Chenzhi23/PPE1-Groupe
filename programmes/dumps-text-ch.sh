#!/usr/bin/env bash

if [ $# -ne 1 ]
then
    echo "Ce script a besoin d'un argument: <URL>."
    exit 1
fi

file="$1"
numero=0

while read -r URL;
do
     numero=$( expr $numero + 1 )
     w3m $URL > ./../dumps-text/ch/fich${numero}-ch.txt
     done < $file





#!/usr/bin/env bash

if [ $# -ne 1 ]
then
    echo "Usage: $0 japonais.txt": <URL>.
    exit 1
fi

file="$1"
numero=0

while read -r URL;
do
     numero=$( expr $numero + 1 )
     w3m $URL > ./../dumps-text/jp/fich${numero}-jp.txt
     done < $file


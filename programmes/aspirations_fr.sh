#!/usr/bin/env bash

URL1=$1
line=1

while read -r URL
do
    curl -o "../aspirations/francais/fr_$line.html" $URL
    line=$(expr $line + 1)
done < ../URLs/$URL1


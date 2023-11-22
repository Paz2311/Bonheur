#!/usr/bin/env bash

URL1=$1
line=1

while read -r URL
do
    lynx -dump $URL > "../dumps-text/espagnol/esp_$line.txt"
    line=$(expr $line + 1)
done < ../URLs/$URL1

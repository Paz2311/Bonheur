#!/usr/bin/env bash

URL=1$
line=1 

while read -r $URL
do 
    curl -O $URL
    line=$(expr $line +1)
done <../URLs/$URL
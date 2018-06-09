#!/bin/bash

cat esi.log | cut -d " " -f 10 >> temp

for i in $(cat temp)
do
    if [ "$i" != "-" ]; then
        echo $i >> tam.data
    fi
done
rm temp

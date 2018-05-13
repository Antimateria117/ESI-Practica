#!/bin/bash

# PETICIONES DIFERENTES: simplemente las ordenamos y quitamos las repetidas
echo 'PETICIONES DIFERENTES'
cat /var/log/apache2/uva.log | grep /2017 | grep ' 200 ' | cut -d ' ' -f 7 | sort | uniq | wc -l
# temporal para el java
cat /var/log/apache2/uva.log | grep /2017 | grep ' 200 ' | cut -d ' ' -f 7 | sort | uniq >> temporalJava

# PETICIONES TOTALES: simplemente es contar las lineas que tiene el fichero
echo 'PETICIONES TOTALES'
cat /var/log/apache2/uva.log | grep ' 200 ' | cut -d ' ' -f 7 | wc -l
# temporal para el java
cat /var/log/apache2/uva.log | grep ' 200 ' | cut -d ' ' -f 7 >> temporalJava

# BYTES DIFERENTES
echo 'BYTES DIFERENTES'
cat /var/log/apache2/uva.log | grep /2017 | grep ' 200 ' | cut -d ' ' -f 10 | sort | uniq >> bytes
let sum=0
for i in $(cat bytes)
do
    if [ "$i" != "-" ]; then
        let sum=$sum+$i
    fi
done
echo $sum
rm bytes

# BYTES TOTALES
echo 'BYTES TOTALES'
cat /var/log/apache2/uva.log | grep /2017 | grep ' 200 ' | cut -d ' ' -f 10 >> bytes
let sum=0
for i in $(cat bytes)
do
    if [ "$i" != "-" ]; then
        let sum=$sum+$i
    fi
done
echo $sum
rm bytes


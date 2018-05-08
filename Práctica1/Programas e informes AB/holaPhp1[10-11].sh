#!/bin/bash

# comandos de AB:
#  -c: concurrency, number of multiple request to perform at a time.
#  -n: number of requests to perform for the benchmarking.
#  -g: gnuplot for the statics.
#  -r: no sale dle programa cuando recibe errores de sockets.
#  -s: timeout for the messages, 50 seconds, if the server has much load.
#      tiene un timeout de 1 min, -s 60 (por defecto son solo 30 seg)
timeOut=60

# $1: el número de la prueba [1-5]
# $2: página web pedida al servidor [webPequena.html - webGrande.html - hola.php]

# tiempo de espera para que el servidor se descargue de trabajo entre ICs
time=10

dir='http://virtual.lab.inf.uva.es:31072/'

# uso del script
if [ "$#" -ne 2 ]; then
	echo "Uso: ./scriptAB numPrueba paginaPeticion"
	exit -1
fi

# creacion de las carpetas de salida de los datos
if [ -d ./informes/ ]; then
	echo "Ya existe la carpeta informes"
else
    echo "Carpeta informes creada"
	mkdir ./informes
	mkdir ./informes/ic1 ./informes/ic2 ./informes/ic3 ./informes/ic4 ./informes/ic5 ./informes/ic6 ./informes/ic7 ./informes/ic8 ./informes/ic9 ./informes/ic10 ./informes/ic11 ./informes/ic12
fi

echo "IC10"
ab -k -c 100 -n 100000 -g ./informes/ic10/graficos$2$1.tsv -r -s $timeOut $dir$2 > ./informes/ic10/datos$2$1
sleep $time

echo "IC11"
ab -k -c 250 -n 100000 -g ./informes/ic11/graficos$2$1.tsv -r -s $timeOut $dir$2 > ./informes/ic11/datos$2$1
sleep $time

echo "Fin del Script - Mirar datos recogidos en ./informes/ic[1-12]/[web]"

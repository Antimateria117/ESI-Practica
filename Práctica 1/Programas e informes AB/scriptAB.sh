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

# inicio del SADC junto con la correspondiente ruta donde se van a guardar los datos
ssh -p 31071 usuario@virtual.lab.inf.uva.es "sar -n DEV -r -u 5 > /home/usuario/Escritorio/sar/$2/carga$1" &

# inicio de las diferentes intensidades de carga
echo "IC1"
ab -k -c 50 -n 1000 -g ./informes/ic1/graficos$2$1.tsv -r -s $timeOut $dir$2 > ./informes/ic1/datos$2$1
echo "fin"
sleep $time

echo "IC2"
ab -k -c 100 -n 1000 -g ./informes/ic2/graficos$2$1.tsv -r -s $timeOut $dir$2 > ./informes/ic2/datos$2$1
sleep $time

echo "IC3"
ab -k -c 100 -n 5000 -g ./informes/ic3/graficos$2$1.tsv -r -s $timeOut $dir$2 > ./informes/ic3/datos$2$1
sleep $time

echo "IC4"
ab -k -c 250 -n 5000 -g ./informes/ic4/graficos$2$1.tsv -r -s $timeOut $dir$2 > ./informes/ic4/datos$2$1
sleep $time

echo "IC5"
ab -k -c 100 -n 10000 -g ./informes/ic5/grafico$2$1.tsvs -r -s $timeOut $dir$2 > ./informes/ic5/datos$2$1
sleep $time

echo "IC6"
ab -k -c 250 -n 10000 -g ./informes/ic6/graficos$2$1.tsv -r -s $timeOut $dir$2 > ./informes/ic6/datos$2$1
sleep $time

echo "IC7"
ab -k -c 100 -n 50000 -g ./informes/ic7/graficos$2$1.tsv -r -s $timeOut $dir$2 > ./informes/ic7/datos$2$1
sleep $time

echo "IC8"
ab -k -c 250 -n 50000 -g ./informes/ic8/graficos$2$1.tsv -r -s $timeOut $dir$2 > ./informes/ic8/datos$2$1
sleep $time

echo "IC9"
ab -k -c 500 -n 50000 -g ./informes/ic9/graficos$2$1.tsv -r -s $timeOut $dir$2 > ./informes/ic9/datos$2$1
sleep $time

echo "IC10"
ab -k -c 100 -n 100000 -g ./informes/ic10/graficos$2$1.tsv -r -s $timeOut $dir$2 > ./informes/ic10/datos$2$1
sleep $time

echo "IC11"
ab -k -c 250 -n 100000 -g ./informes/ic11/graficos$2$1.tsv -r -s $timeOut $dir$2 > ./informes/ic11/datos$2$1
sleep $time

echo "IC12"
ab -k -c 500 -n 100000 -g ./informes/ic12/graficos$2$1.tsv -r -s $timeOut $dir$2 > ./informes/ic12/datos$2$1
sleep $time

# ejecucion del comando para parar el monitor SADC
ssh -p 31071 usuario@virtual.lab.inf.uva.es "pkill -9 sar"

echo "Fin del Script - Mirar datos recogidos en ./informes/ic[1-12]/[web]"

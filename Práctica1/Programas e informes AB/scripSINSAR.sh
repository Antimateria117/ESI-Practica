#!/bin/bash

# comandos de AB:
#  -c: concurrency, number of multiple request to perform at a time.
#  -n: number of requests to perform for the benchmarking.
#  -g: gnuplot for the statics.
#  -r: no sale dle programa cuando recibe errores de sockets.
#  -s: timeout for the messages, 50 seconds, if the server has much load.

# $1: el número de la prueba [1-5]
# $2: página web pedida al servidor [webPequena.html - webGrande.html - hola.php]

if [ "$#" -ne 2 ]; then
    echo "Faltan los argumentos"
    exit 1
fi

mkdir ./informes
mkdir ./informes/ic1 ./informes/ic2 ./informes/ic3 ./informes/ic4 ./informes/ic5 ./informes/ic6 ./informes/ic7 ./informes/ic8 ./informes/ic9 ./informes/ic10 ./informes/ic11 ./informes/ic12

echo "IC1"
ab -c 50 -n 1000 -g ./informes/ic1/graficos$2$1.tsv -r -s 50 http://virtual.lab.inf.uva.es:31072/$2 > ./informes/ic1/datos$2$1
echo "fin"
sleep 2

echo "IC2"
ab -c 100 -n 1000 -g ./informes/ic2/graficos$2$1.tsv -r -s 50 http://virtual.lab.inf.uva.es:31072/$2 > ./informes/ic2/datos$2$1
sleep 2

echo "IC3"
ab -c 100 -n 5000 -g ./informes/ic3/graficos$2$1.tsv -r -s 50 http://virtual.lab.inf.uva.es:31072/$2 > ./informes/ic3/datos$2$1
sleep 2

echo "IC4"
ab -c 250 -n 5000 -g ./informes/ic4/graficos$2$1.tsv -r -s 50 http://virtual.lab.inf.uva.es:31072/$2 > ./informes/ic4/datos$2$1
sleep 2

echo "IC5"
ab -c 100 -n 10000 -g ./informes/ic5/grafico$2$1.tsvs -r -s 50 http://virtual.lab.inf.uva.es:31072/$2 > ./informes/ic5/datos$2$1
sleep 2

echo "IC6"
ab -c 250 -n 10000 -g ./informes/ic6/graficos$2$1.tsv -r -s 50 http://virtual.lab.inf.uva.es:31072/$2 > ./informes/ic6/datos$2$1
sleep 2

echo "IC7"
ab -c 100 -n 50000 -g ./informes/ic7/graficos$2$1.tsv -r -s 50 http://virtual.lab.inf.uva.es:31072/$2 > ./informes/ic7/datos$2$1
sleep 2

echo "IC8"
ab -c 250 -n 50000 -g ./informes/ic8/graficos$2$1.tsv -r -s 50 http://virtual.lab.inf.uva.es:31072/$2 > ./informes/ic8/datos$2$1
sleep 2

echo "IC9"
ab -c 500 -n 50000 -g ./informes/ic9/graficos$2$1.tsv -r -s 50 http://virtual.lab.inf.uva.es:31072/$2 > ./informes/ic9/datos$2$1
sleep 2

echo "IC10"
ab -c 100 -n 100000 -g ./informes/ic10/graficos$2$1.tsv -r -s 50 http://virtual.lab.inf.uva.es:31072/$2 > ./informes/ic10/datos$2$1
sleep 2

echo "IC11"
ab -c 250 -n 100000 -g ./informes/ic11/graficos$2$1.tsv -r -s 50 http://virtual.lab.inf.uva.es:31072/$2 > ./informes/ic11/datos$2$1
sleep 2

echo "IC12"
ab -c 500 -n 100000 -g ./informes/ic12/graficos$2$1.tsv -r -s 50 http://virtual.lab.inf.uva.es:31072/$2 > ./informes/ic12/datos$2$1
sleep 2

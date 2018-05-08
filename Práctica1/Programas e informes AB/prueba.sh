#!/bin/bash

ssh -p 31071 usuario@virtual.lab.inf.uva.es "sar -n DEV -r -u 5 > /home/usuario/Escritorio/sar/ic1/sar$2$1" &
ab -c 50 -n 1000 -g ./informes/ic1/graficos$2$1.tsv -r -s 50 http://virtual.lab.inf.uva.es:31072/$2 > ./informes/ic1/datos$2$1
ssh -p 31071 usuario@virtual.lab.inf.uva.es "pkill -9 sar" 
sleep 2
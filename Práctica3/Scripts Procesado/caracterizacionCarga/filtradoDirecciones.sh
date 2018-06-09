#!/bin/bash

# procesamos para calcular el numero de accesos
echo "Generando fichero para Numero de Accesos"
cat resultados.log | cut -d " " -f 7 >> todasDirecciones.data
echo "Fichero Numero Accesos Generado: todasDirecciones.data"

# procesamos para el tamaño medio de los ficheros
echo "Generando fichero para Tamaño Medio"
cat resultados.log | cut -d " " -f 10 >> todosTamaños.data
echo "Fichero Tamaños Medios Generado: todosTamanos.data"

# procesamos para el tiempo de ejecucion de cada fichero
echo "Generando fichero para el tiempo de ejecucion"
cat resultados.log | cut -d " " -f 11 >> todosiTiempos.data
echo "Fichero Tamaños Medios Generado: todosTamanos.data"

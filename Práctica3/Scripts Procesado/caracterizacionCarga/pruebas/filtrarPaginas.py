#!/usr/bin/env python
# -*- coding: utf-8 -*-

import re
import os
import os.path as path

# primero compilamos los filtors necesarios para las expresiones regulares
# este filtro nos devuelve todas las direcciones de las páinas web
getNombres = re.compile('\s/\S*')
getNumeros = re.compile('\s\d+')

# abrimos los ficheros necesario, en este caso el log de lectura y el resultados en escritura
f = open("resultados.log")

# si ya existe nuestro fichero, lo borramos para asegurarnos de que los datos que procesamos son los correctos
if path.exists("resultadosClusters.data"):
    os.remove("resultadosClusters.data")
r = open("resultadosClusters.data", "w")

dic = {}
i = 0

#filtramos el fichero de log
for linea in f:
    # para cada linea cokprobamos si el filtro encuentra algo, (siempre debería encontrar algo)
    if (getNombres.search(linea) != None):
        # primero tenemos que mirar si exista ya en el diccionario si no existe lo tenemos que añadir, si existe no lo añadimos
        if (dic.get(linea) == None):
            temp2 = linea.split()
            dic[temp2[6]] = i
            i += 1

print dic.values()
# ya tenemos el diccionario de direcciones con sus indidces, ahora creamos la matriz que va a ser
w, h = 3, len(dic);
matrix = [[0 for x in range(w)] for y in range(h)]

# recolocamos el puntero del fichero para que apunte otra vez al princpio del fichero
f.seek(0,0)
for linea in f:
    if (getNombres.search(linea) != None):
        # se supone que todas las direcciones están indexadas en el diccionario, simplemente obtenemos el indice e introducimos los datos en el array conrrespondiente
        indice = dic.get(linea)
        if (getNumeros.search(linea) != None):
            temp = (int(s) for s in linea.split() if s.isdigit())


print("Fichero analizado, resultados en: resultados.log")

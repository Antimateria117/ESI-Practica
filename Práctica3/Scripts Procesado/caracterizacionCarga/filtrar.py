import re
import os
import os.path as path

# primero compilamos los filtors necesarios para las expresiones regulares
get = re.compile('GET')
get200 = re.compile(' 2[0-9][0-9] ')
get300 = re.compile(' 3[0-9][0-9] ')

# abrimos los ficheros necesario, en este caso el log de lectura y el resultados en escritura
f = open("esi.log")
# si ya existe nuestro fichero, lo borramos para asegurarnos de que los datos que procesamos son los correctos
if path.exists("resultados.log"):
    os.remove("resultados.log")
r = open("resultados.log", "w")

print("Analizando el fichero y generando resultados ...")

#filtramos el fichero de log
for linea in f:
    # para cada linea comprobamos, que sea una peticion de tipo get y si es 2XX o 3XX
    if (get.search(linea) != None):
        if (get200.search(linea) != None):
            r.write(linea)
        if (get300.search(linea) != None):
            r.write(linea)

print("Fichero analizado, resultados en: resultados.log")

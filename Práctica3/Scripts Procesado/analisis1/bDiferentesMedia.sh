#!/bin/bash

mes=/Dec
# primero obtenemos todos los accesos para un TIPO de ficheros y los dejamos en el archivo temporal del tipo correspondiente
cat /var/log/apache2/uva.log | grep '.htm ' | grep $mes | grep ' 200 ' | cut -d ' ' -f 10 >> HTML
cat /var/log/apache2/uva.log | grep '.html '| grep $mes | grep ' 200 ' | cut -d ' ' -f 10 >> HTML
cat /var/log/apache2/uva.log | grep '.xml ' | grep $mes | grep ' 200 ' |  cut -d ' ' -f 10 >> HTML

cat /var/log/apache2/uva.log | grep '.jpg ' | grep $mes | grep ' 200 ' |cut -d ' ' -f 10 >> IMAGEN
cat /var/log/apache2/uva.log | grep '.png ' | grep $mes | grep ' 200 ' | cut -d ' ' -f 10 >> IMAGEN
cat /var/log/apache2/uva.log | grep '.gif ' | grep $mes | grep ' 200 ' |cut -d ' ' -f 10 >> IMAGEN
cat /var/log/apache2/uva.log | grep '.ico ' | grep $mes | grep ' 200 ' |cut -d ' ' -f 10 >> IMAGEN
cat /var/log/apache2/uva.log | grep '.jpeg ' | grep $mes | grep ' 200 ' |cut -d ' ' -f 10 >> IMAGEN
cat /var/log/apache2/uva.log | grep '.svg ' | grep $mes | grep ' 200 ' | cut -d ' ' -f 10 >> IMAGEN

cat /var/log/apache2/uva.log | grep '.mp3 ' | grep $mes | grep ' 200 ' |cut -d ' ' -f 10 >> SONIDO

cat /var/log/apache2/uva.log | grep '.flv ' | grep $mes | grep ' 200 ' |cut -d ' ' -f 10 >> VIDEO
cat /var/log/apache2/uva.log | grep '.mp4 ' | grep $mes | grep ' 200 ' |cut -d ' ' -f 10 >> VIDEO

cat /var/log/apache2/uva.log | grep '.pdf ' | grep $mes | grep ' 200 ' |cut -d ' ' -f 10 >> ARCHIVO
cat /var/log/apache2/uva.log | grep '.doc ' | grep $mes | grep ' 200 ' |cut -d ' ' -f 10 >> ARCHIVO
cat /var/log/apache2/uva.log | grep '.docx ' | grep $mes | grep ' 200 ' |cut -d ' ' -f 10 >> ARCHIVO
cat /var/log/apache2/uva.log | grep '.pptx ' | grep $mes | grep ' 200 ' | cut -d ' ' -f 10 >> ARCHIVO
cat /var/log/apache2/uva.log | grep '.gz ' | grep $mes | grep ' 200 ' | cut -d ' ' -f 10 >> ARCHIVO
cat /var/log/apache2/uva.log | grep '.xlsx ' | grep $mes | grep ' 200 ' |cut -d ' ' -f 10 >> ARCHIVO
cat /var/log/apache2/uva.log | grep '.ppsx ' | grep $mes | grep ' 200 ' |cut -d ' ' -f 10 >> ARCHIVO

cat /var/log/apache2/uva.log | grep '.css ' | grep $mes | grep ' 200 ' | cut -d ' ' -f 10 >> FORMATO

cat /var/log/apache2/uva.log | grep '.woff '| grep $mes | grep ' 200 ' | cut -d ' ' -f 10 >> OTRO
cat /var/log/apache2/uva.log | grep '.ova '| grep $mes | grep ' 200 ' | cut -d ' ' -f 10 >> OTRO

cat /var/log/apache2/uva.log | grep '.js '| grep $mes | grep ' 200 ' | cut -d ' ' -f 10 >> DINAMICA
cat /var/log/apache2/uva.log | grep '.php '| grep $mes | grep ' 200 ' |cut -d ' ' -f 10 >> DINAMICA

let sum=0
let dias=31
for i in $(cat HTML | sort | uniq)
do
	if [ "$i" != "-" ]; then
		let sum=$sum+$i
	fi
done
let sum=$sum/$dias
echo Media peticiones dia HTML: $sum
rm HTML

let sum=0
for i in $(cat ARCHIVO | sort | uniq)
do
	if [ "$i" != "-" ]; then
		let sum=$sum+$i
	fi
done
let sum=$sum/$dias
echo Media peticiones dia ARCHIVOS: $sum
rm ARCHIVO

let sum=0
for i in $(cat FORMATO | sort | uniq)
do
	if [ "$i" != "-" ]; then
		let sum=$sum+$i
	fi
done
let sum=$sum/$dias
echo Media peticiones dia FORMATO: $sum
rm FORMATO

let sum=0
for i in $(cat IMAGEN | sort | uniq)
do
	if [ "$i" != "-" ]; then
		let sum=$sum+$i
	fi
done
let sum=$sum/$dias
echo Media peticiones dia IMAGEN: $sum
rm IMAGEN

let sum=0
for i in $(cat OTRO | sort | uniq)
do
	if [ "$i" != "-" ]; then
		let sum=$sum+$i
	fi
done
let sum=$sum/$dias
echo Media peticiones dia OTROS: $sum
rm OTRO

let sum=0
for i in $(cat SONIDO | sort | uniq)
do
	if [ "$i" != "-" ]; then
		let sum=$sum+$i
	fi
done
let sum=$sum/$dias
echo Media peticiones dia SONDIO: $sum
rm SONIDO

let sum=0
for i in $(cat VIDEO | sort | uniq)
do
	if [ "$i" != "-" ]; then
		let sum=$sum+$i
	fi
done
let sum=$sum/$dias
echo Media peticiones dia VIDEO: $sum
rm VIDEO

let sum=0
for i in $(cat DINAMICA | sort | uniq)
do
	if [ "$i" != "-" ]; then
		let sum=$sum+$i
	fi
done
let sum=$sum/$dias
echo Media peticiones dia DINAMICAS: $sum
rm DINAMICA

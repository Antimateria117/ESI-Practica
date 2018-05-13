#!/bin/bash

mes=/Dec
# primero obtenemos todos los accesos para un TIPO de ficheros y los dejamos en el archivo temporal del tipo correspondiente
cat /var/log/apache2/uva.log | grep '.htm ' | grep $mes | grep ' 200 ' | wc -l >> HTML
cat /var/log/apache2/uva.log | grep '.html '| grep $mes | grep ' 200 ' | wc -l >> HTML
cat /var/log/apache2/uva.log | grep '.xml ' | grep $mes | grep ' 200 ' | wc -l >> HTML

cat /var/log/apache2/uva.log | grep '.jpg ' | grep $mes | grep ' 200 ' | wc -l >> IMAGEN
cat /var/log/apache2/uva.log | grep '.png ' | grep $mes | grep ' 200 ' | wc -l >> IMAGEN
cat /var/log/apache2/uva.log | grep '.gif ' | grep $mes | grep ' 200 ' | wc -l >> IMAGEN
cat /var/log/apache2/uva.log | grep '.ico ' | grep $mes | grep ' 200 ' | wc -l >> IMAGEN
cat /var/log/apache2/uva.log | grep '.jpeg ' | grep $mes | grep ' 200 ' | wc -l >> IMAGEN
cat /var/log/apache2/uva.log | grep '.svg ' | grep $mes | grep ' 200 ' | wc -l >> IMAGEN

cat /var/log/apache2/uva.log | grep '.mp3 ' | grep $mes | grep ' 200 ' | wc -l >> SONIDO

cat /var/log/apache2/uva.log | grep '.flv ' | grep $mes | grep ' 200 ' | wc -l >> VIDEO
cat /var/log/apache2/uva.log | grep '.mp4 ' | grep $mes | grep ' 200 ' | wc -l >> VIDEO

cat /var/log/apache2/uva.log | grep '.pdf ' | grep $mes | grep ' 200 ' | wc -l >> ARCHIVOS
cat /var/log/apache2/uva.log | grep '.doc ' | grep $mes | grep ' 200 ' | wc -l >> ARCHIVOS
cat /var/log/apache2/uva.log | grep '.docx ' | grep $mes | grep ' 200 ' | wc -l >> ARCHIVOS
cat /var/log/apache2/uva.log | grep '.pptx ' | grep $mes | grep ' 200 ' | wc -l >> ARCHIVOS
cat /var/log/apache2/uva.log | grep '.gz ' | grep $mes | grep ' 200 ' | wc -l >> ARCHIVOS
cat /var/log/apache2/uva.log | grep '.xlsx ' | grep $mes | grep ' 200 ' | wc -l >> ARCHIVOS
cat /var/log/apache2/uva.log | grep '.ppsx ' | grep $mes | grep ' 200 ' | wc -l >> ARCHIVOS

cat /var/log/apache2/uva.log | grep '.css ' | grep $mes | grep ' 200 ' | wc -l >> FORMATO

cat /var/log/apache2/uva.log | grep '.woff '| grep $mes | grep ' 200 ' | wc -l >> OTROS
cat /var/log/apache2/uva.log | grep '.ova '| grep $mes | grep ' 200 ' | wc -l >> OTROS

cat /var/log/apache2/uva.log | grep '.js '| grep $mes | grep ' 200 ' | wc -l >> DINAMICAS
cat /var/log/apache2/uva.log | grep '.php '| grep $mes | grep ' 200 ' | wc -l >> DINAMICAS


let diasSemana=31
let sum=0

for i in $(cat HTML)
do
	let sum=$sum+$i
done
let sum=$sum/$diasSemana
echo Media peticiones dia HTML: $sum
rm HTML

let sum=0
for i in $(cat ARCHIVOS)
do
	let sum=$sum+$i
done
let sum=$sum/$diasSemana
echo Media peticiones dia ARCHIVOS: $sum
rm ARCHIVOS

let sum=0
for i in $(cat FORMATO)
do
	let sum=$sum+$i
done
let sum=$sum/$diasSemana
echo Media peticiones dia FORMATO: $sum
rm FORMATO

let sum=0
for i in $(cat IMAGEN)
do
	let sum=$sum+$i
done
let sum=$sum/$diasSemana
echo Media peticiones dia IMAGEN: $sum
rm IMAGEN

let sum=0
for i in $(cat OTROS)
do
	let sum=$sum+$i
done
let sum=$sum/$diasSemana
echo Media peticiones dia OTROS: $sum
rm OTROS

let sum=0
for i in $(cat SONIDO)
do
	let sum=$sum+$i
done
let sum=$sum/$diasSemana
echo Media peticiones dia SONDIO: $sum
rm SONIDO

let sum=0
for i in $(cat VIDEO)
do
	let sum=$sum+$i
done
let sum=$sum/$diasSemana
echo Media peticiones dia VIDEO: $sum
rm VIDEO

let sum=0
for i in $(cat DINAMICAS)
do
	let sum=$sum+$i
done
let sum=$sum/$diasSemana
echo Media peticiones dia DINAMICAS: $sum
rm DINAMICAS

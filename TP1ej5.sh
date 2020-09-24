#!/bin/bash
#
#Un directorio contiene archivos cuyos nombres poseen mayúsculas, minúsculas y espacios. 
#Escriba un script que convierta todos los nombres de archivos en minúsculas y los espacios 
#en ’_’. Informe cuántos archivos se renombraron. Nota: puede utilizar el comando tr.
#
#espera un find /directorio -type f -print0
#
while IFS= read -r archivo
do
    mv "$archivo" $(echo "$archivo" | tr [:lower:][:upper:] | tr " " _)
done
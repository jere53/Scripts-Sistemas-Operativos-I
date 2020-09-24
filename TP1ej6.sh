#!/bin/bash
#
#Implemente un script reciba un nombre de directorio, correspondiente al directorio de código
#fuente de un proyecto Java, y construya los siguientes reportes:
#Cantidad de clases/interfaces importadas (diferentes) en cada archivo de código fuente.
#
#espera un directorio, busca recursivamente todos los archivos que sean sources de java
#No es necesario ver que ande con espacios porque los archivos .java no pueden tener espacios
find "$1" -type f -name "*.java" | while read -r archivo
do
    echo "$archivo" importa $(grep -c "#imports*" "$archivo") clases.
done
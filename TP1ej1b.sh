#!/bin/bash
#
#Reemplace los dígitos del contenido de un archivo por un carácter dado como parámetro
#
archivo=$1
caracter=$2
#usa comillas dobles para que acepte la variable $2
sed -i "s/[0-9]/$caracter/g" $archivo
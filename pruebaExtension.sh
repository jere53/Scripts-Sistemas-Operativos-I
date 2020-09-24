#!/bin/bash
#prueba de extraer la extension de un archivo
read file
filename=$(basename -- "$file")
echo "${filename##*.}"
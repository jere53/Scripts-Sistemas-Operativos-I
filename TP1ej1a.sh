#!/bin/bash
#
# Convierta el contenido de un archivo de texto a mayúsculas y guarde el resultado sobre el
# mismo archivo.
#
#traduce texto.txt a mayusculas y guarda el resultado en un archivo auxiliar
tr a-z A-Z < texto.txt > aux.txt
#pasa el contenido del aux al archivo original
cat aux.txt > texto.txt
#borra el auxiliar
rm aux.txt
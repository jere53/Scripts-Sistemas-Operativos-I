#!/bin/bash
#
#Implemente el comando “tac”, que genera la inversa de un archivo de texto, es decir, la última
#línea primero y así sucesivamente
#
#numeramos todas las lineas | ordenamos en reversa | imprimimos sin numero de linea
archivo=$1
cat -n $archivo | sort -r -n | cut -f2-
# el cut -f2 imprime todo lo que este despues del primer tab. Los numeros de linea del
#car -n estan separados del texto por un tab
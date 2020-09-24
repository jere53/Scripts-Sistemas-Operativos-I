#!/bin/bash
#
#Realice un listado recursivo de los archivos del directorio HOME de un usuario 
#y guarde la información en un archivo.
#
find $HOME -ls > listadoHome.txt
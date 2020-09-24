#!/bin/bash
#
#Dada una lista de archivos, escriba un script que basado en el tipo (extensión) de cada uno
#de ellos (.gz, .bz2, .zip, .tar), invoque automáticamente el comando apropiado para
#descomprimirlo (gunzip, bunzip2, unzip, tar). Si un archivo no está comprimido, el script 
#debe mostrar un mensaje y continuar con el siguiente archivo.
#
#Se asume que entra una lista de archivos
#cambiamos el separador de campos a NULL pora que acepte nombres con espacios
while IFS= read -r archivo
do
    #conseguimos el nombre del archivo
    filename=$(basename -- "$archivo")
    #miramos solo la extension, ${} expande el parametro (filename), es decir da un string con
    #el nombre del archivo. '##' dice que borre del string el patron mas largo que matchee con
    #el '*' y este antes de un '.'. Es decir, borra del string todo lo que este antes del ultimo
    #punto. Lo que nos queda deberia ser la extension, en caso de que tenga mas de un punto
    #com .tar.gz, escribe solo la ultima (.gz).
    case "${filename##*.}" in

        gz )
            gunzip -d "$archivo"
            echo Descomprimido "$archivo"
        ;;

        bz2 )
            bzip2 -d "$archivo"
            echo Descomprimido "$archivo"
        ;;

        zip | tar)
            tar xvf "$archivo"
            echo Descomprimido "$archivo"
        ;;

        #por defecto
        * ) 
            echo "$archivo" no puede ser descomprimido
        ;;
    esac
done
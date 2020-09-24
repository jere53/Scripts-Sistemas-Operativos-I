#!/bin/bash
#
#Liste, uno a la vez, todos los archivos mayores de 100K en el directorio HOME de un usuario.
#De al usuario la opción de eliminar o comprimir el archivo (usando el comando read), luego 
#proceda a mostrar el siguiente. Escriba en un archivo de log los nombres de todos los 
#archivos eliminados y la fecha. Puede utilizar el comando ls o find
#
#creamos el log, reemplazar la variable si se quiere cambiar el destino (del comando)
log=$'/home/jere/Facultad/Sistemas Operativos/Scripts/ElimLog.txt'
echo Archivos Eliminados > "$log" #comillas para que no tire "ambiguous redirect"
#
#que busque en home - que sean archivos - que sean mas grandes que 100k
#-print0 para que use NULL como separador, asi no piensa que espacios o caracteres especiales
#en un nombre de archivo son 2 archivos.
#itera sobre el resultado con un while-read. el -d $'\0' dice que use NULL como separador
#al leer (como lo setteamos con -print0). guardamos lo que leyo (path) en la variable archivo.
find /home/jere/PruebaScriptsSO -type f -size +100k -print0 | while read -d $'\0' archivo 
do
    echo "Archivo: $archivo"
    # en el read va </dev/tty para que reciba la entrada de la terminal
    STR=$'Presione C para comprimir el archivo. E para eliminar el archivo. Otra tecla para omitir\n'
    read -p "$STR" -n 1 -r </dev/tty
    #inserta una linea para que se vea bien
    echo
    if [[ $REPLY =~ ^[Cc]$ ]]; then
        #-p es de prompt, -n 1 dice que acepte un solo caracter, -r los \ sean literales
        #$REPLY es el nombre por defecto de la variable para contestar al -p
        #echo para que inserte otra linea y se vea bien
        read -p "Seguro que desea comprimir el archivo? (y/n) " -n 1 -r </dev/tty
        echo
        #regex pregunta si coincide (=~) con una Y o y, $ y ^ para que solo acepte 1 caracter
        if [[ $REPLY =~ ^[Yy]$ ]]; then 
            #que comprima usando gzip
            gzip "$archivo" #comillas para que no se rompa con los espacios
            echo "Archivo comprimido con exito!"
        else
            echo Cancelado        
        fi
    elif [[ $REPLY =~ ^[Ee]$ ]]; then
        read -p "Seguro que desea eliminar el archivo? (y/n) " -n 1 -r </dev/tty
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            #guarda el nombre y la fecha en el log
            echo `date` - Se elimino: "$archivo" >> "$log"
            rm "$archivo"
        else
            echo Cancelado        
        fi
    else
        echo Omitiendo
    fi
done
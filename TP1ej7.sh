#!/bin/bash
#
#Codifique un script para mantener un log circular de aplicación. Un log en general es un 
#archivo donde una aplicación guarda mensajes de error o advertencia, mientras que un log
#circular funciona como sigue: cada vez que el script es invocado, verifica en un directorio
#de aplicación (parámetro) dentro de “/var/log” por la existencia de un archivo determinado. 
#Si el tamaño de dicho archivo no sobrepasa un valor T, no hace nada. Si sobrepasa, 
#comprime dicho archivo mediante gzip, y lo borra. Al archivo comprimido se le asigna un 
#prefijo que indica el número de archivos gzip creados en sucesivas invocaciones al script. 
#Cuando la cantidad de archivos es L (tamaño del log circular), se debe también borrar el 
#archivo gzip creado más viejo. Por ejemplo, si las entradas son:
#
#* /var/log/tomcat5.5/catalina.out (log de la aplicación)
#* /var/log/tomcat5.5/slot#1-catalina.out.gz
#* . . .
#* /var/log/tomcat5.5/slot#[L]-catalina.out.gz
#
#el próximo archivo gzip a borrar es “slot#1-catalina.out.gz”. Implemente luego una variante 
#del script que cree versiones del archivo de log principal siempre y cuando no ocupen en 
#conjunto más de B bytes.
#
declare -i T=5000000 #tamanio del archivo en B (5MB)
declare -i L=10 #tamanio del log en cant archivos
declare -i cant=0 #una variable que guarda cuantos archivos tenemos
#$1 es el directorio de aplicacion
#que busque archivos con mylog, que use null como separador, que el while use null como IFS, que escape /
 
 #NO anda, preguntar porque!
#find "$1" -type f -name "*mylog*" -print0 | while IFS= read -r archivo
find "$1" -type f -name "*mylog*" | while read -r archivo
do
    declare -i filesize="$(wc -c < "$archivo")" #tamanio del archivo en bytes
    if [ $(("$filesize" >= "$T")) ]; then #si es mayor o igual al tamanio max
        ((cant++)) #incrementa la cantidad de archivos
        gzip "$archivo" #comprime y borra el original
        mv "$archivo".gz "$archivo-slot#$cant-".gz #agrega el prefijo
        if [ $(($cant >= $L)) ]; then #si nos pasamos del tamanio del log
            declare -i nroaborrar=$(($cant - $L)) #calcula el prefijo mas viejo
            rm "$archivo-slot#$nroaborrar".gz #el nombre del log mas viejo, lo borra
        fi
    fi
done
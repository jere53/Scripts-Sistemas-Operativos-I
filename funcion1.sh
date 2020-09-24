#!/bin/bash
#Ejemplo de Funcion
hello="hello"
function cambiarHello {
    local hello="world"
    echo $hello
}
echo $hello
cambiarHello
echo $hello
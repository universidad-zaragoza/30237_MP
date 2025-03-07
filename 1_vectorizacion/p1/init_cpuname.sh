#!/bin/bash

# Obtener el nombre del host
JOSTNAME=$(hostname)

if [ "$JOSTNAME" == "lab000" ]; then
    CPU="e5-2450"
#elif [ "$JOSTNAME" == "labxxx" ]; then
#    CPU="xxx"
else
    CPU=`cat /proc/cpuinfo | grep 'model name' | uniq | cut -d " " -f 5`
fi

echo "modelo de procesador: "$CPU
export CPU=$CPU

# export CPU=i5-3470  # cambiar por modelo de cpu correspondiente
                    # less /proc/cpuinfo
                    # campo "model name"

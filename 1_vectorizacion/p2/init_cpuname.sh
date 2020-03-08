#!/bin/bash

CPU=`cat /proc/cpuinfo | grep 'model name' | uniq | cut -d " " -f 5`
echo "modelo de procesador: "$CPU
export CPU=$CPU

# export CPU=i5-3470  # cambiar por modelo de cpu correspondiente
                    # less /proc/cpuinfo
                    # campo "model name"

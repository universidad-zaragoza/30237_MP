#!/bin/bash

# uso:
#    ./clean.sh

[ -z "$CPU" ] && echo "Hay que inicializar la variable CPU (source ./init_cpuname.sh)" && exit 1;
#: ${CPU:?"Hay que inicializar la variable CPU (source ./init_cpuid.sh)"}

# valores por defecto

cd $CPU
rm -f *.o
rm -f *gcc*
rm -f assembler/*
rm -f reports/*
rm -f results/*
rm -f aps/*


#!/bin/bash

remote=/home/chus/automounts/hendrix_chus/docencia/mp/p6_openmp_simd/

if [ "$#" -eq 0 ]; then
    for fichero in *.c *.sh *md; do
        meld $fichero ${remote}/$fichero
    done
    exit
fi

meld $1 ${remote}/$1

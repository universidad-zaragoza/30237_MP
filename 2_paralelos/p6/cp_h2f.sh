#!/bin/bash

remote=/home/chus/Dropbox/2_trabajo/4_docencia/grado_inform/Multiprocesadores/3_Practicas/2_paralelismo/p6_openmp_simd/

if [ "$#" -eq 0 ]; then
    cp *.c   ${remote}
    cp *.h   ${remote}
    cp *.sh  ${remote}
    exit
fi

cp $1  ${remote}


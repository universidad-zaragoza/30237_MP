#!/bin/bash

remote=lab000:docencia/mp/p6_openmp_simd/
#remote=/home/chus/automounts/hendrix_chus/docencia/mp/p6_openmp_simd/

if [ "$#" -eq 0 ]; then
    scp *.c   ${remote}
    scp *.h   ${remote}
    scp *.sh  ${remote}
    #scp -r iaca-lin64 ${remote}
    exit
fi

scp $1  ${remote}

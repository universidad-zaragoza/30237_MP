#!/bin/bash

compiler=gcc
precision_list=(0)
#precision_list=(0 1)

# 3 vectores de 2K elementos -> cabe en L1
# 3 vectores de 8K elementos -> no cabe en L1, cabe en L2
# 3 vectores de 32K elementos -> no cabe en L2, cabe en L3
# 3 vectores de 256K elementos -> no cabe en L2, cabe en L3
# 3 vectores de 1024K elementos -> no cabe en L3
vectorlen_list=(2 8 32 256 1024)

for precision in "${precision_list[@]}"; do
    for vlen in "${vectorlen_list[@]}"; do
        ./comp.omp.sh -c ${compiler} -l ${vlen}  -p ${precision}
        ./run.aps.sh  -c ${compiler} -l ${vlen}  -p ${precision}
    done
done

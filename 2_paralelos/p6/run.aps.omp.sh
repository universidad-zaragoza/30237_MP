#!/bin/bash

# APS: Application Performance Snapshot

# uso:
#    ./run.aps.omp.sh -c compilador -f fichero -l vector_len (Kelements) -p precision
# ejemplo
#    ./run.aps.omp.sh -c gcc  -f s000.c -l 2 -p 0

[ -z "$CPU" ] && echo "Hay que inicializar la variable CPU (source ./init_cpuname.sh)" && exit 1;
[ ! -d "$CPU" ] && echo "No se ha compilado" && exit 1;

# Ubicación de aps
# lab102: ya está incluido en el PATH
# export PATH=$PATH:/usr/local/bin
# central
# export PATH=$PATH:/usr/local/pkg/APS_2017_lin_478468
# export PATH=$PATH:/opt/intel/APS_2017_lin_478468

# no parece necesario
# source /usr/local/pkg/aps/apsvars.sh

# valores por defecto
src="triad.c"
comp=gcc
vlenk=32   # 32K elementos

# floating point precision, 
#    p=0 corresponds to single precision
#    p=1 corresponds to double precision
p=0

while getopts "f:c:l:p:h" opt; do
  case $opt in
    f) 
      src=$OPTARG
      ;;
    c)
      comp=$OPTARG
      ;;
    l) 
      vlenk=$OPTARG
      vlen=$((vlenk*1024))
      ;;
    p) 
      # echo "especificado precision -> $OPTARG"
      p=$OPTARG
      ;;
    h)
      echo "uso:"
      echo "$0 -f fichero  -c compilador"
      echo "ejemplo:"
      echo "$0 -f s000  -c gcc"
      exit
      ;;
    \?)
      echo "opción inválida: -$OPTARG"
      exit 1
      ;;
    :)
      echo "la opción -$OPTARG requiere un parámetro"
      exit 1
      ;;
  esac
done

case $p in
    0 )
        precision="single"
        ;;
    1 )
        precision="double"
        ;;
    * )
        echo "precision no soportada"
        exit 1
        ;;
esac

id="${src%.*}"    # extract .c

cd $CPU
mkdir -p aps

version_list=(noavx.omp avx.omp)
#version_list=(noavx.omp avx.omp avx.noomp noavx.noomp)
nth_list=(1 2 4)

# loop over the vector/scalar binaries
for version in "${version_list[@]}"; do
    binario=${id}.${version}.${vlenk}k.${precision}.${comp}
    echo -n "ejecutando aps ./${binario} ... "
    for nth in "${nth_list[@]}"; do
        echo -n "$nth "
        OMP_NUM_THREADS=${nth} aps ./${binario} > aps/${binario}.${nth}th.txt ${nth}  2>&1
        # dummy parameter to match experiment results
        # OMP_NUM_THREADS=${nth} aps ./${binario} ${nth} > aps/${binario}.${nth}th.txt ${nth}  2>&1
        # mkdir -p aps/${binario}.${nth}th
        # OMP_NUM_THREADS=${nth}  aps -r=aps/${binario}.${nth}th ./${binario} > aps/${binario}.${nth}th/${binario}.${nth}th.txt ${nth}  2>&1
    done
    echo OK
done    
    
exit

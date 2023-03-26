#!/bin/bash

# uso:
#    ./run.iaca.sh -c compilador -f fichero -p precision
# ejemplo
#    ./run.iaca.sh -c gcc  -f s000.c

[ -z "$CPU" ] && echo "Hay que inicializar la variable CPU (source ./init_cpuname.sh)" && exit 1;
[ ! -d "$CPU" ] && echo "No se ha compilado" && exit 1;

# ubicación de IACA
# lab102: ya está incluido en el PATH
# export PATH=$PATH:/usr/local/bin
# central
# export PATH=$PATH:/usr/local/pkg/iaca-lin64/bin
# fermat
# export PATH=$PATH:/opt/intel/iaca-lin64/

# valores por defecto
src="triad.c"
comp=gcc

# floating point precision, 
#    p=0 corresponds to single precision
#    p=1 corresponds to double precision
p=0

while getopts "f:c:p:h" opt; do
  case $opt in
    f) 
      # echo "especificado fichero -> $OPTARG"
      src=$OPTARG
      ;;
    c) 
      # echo "especificado compilador -> $OPTARG"
      comp=$OPTARG
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
mkdir -p results
mkdir -p iaca

# solamente la versión escalar secuencial
version_list=(noavx)
# version_list=(noavx avx)
arch_list=(HSW SKL)   # arch_list=(HSW SKL SKX)

# loop over the binaries
for version in "${version_list[@]}"; do
    binario=${id}.${version}.${precision}.${comp}.iaca
    for arch in "${arch_list[@]}"; do
        echo -n "realizando análisis estático de ${binario} sobre ${arch}... "

        # IACA: Intel Architecture Code Analyzer
        # set -x
        # iaca -arch ${arch} -trace iaca/${binario}.traza.${arch}.txt ./${binario} > iaca/${binario}.thrput.${arch}.txt   2>&1 && echo "OK"
        iaca -arch ${arch} -trace iaca/${binario}.traza.${arch}.txt ./${binario} > iaca/${binario}.thrput.${arch}.txt
        echo "OK"
        # set +x

        # version 2.2
        # iaca -arch ${arch}  -graph iaca/deps.${binario}.thr.${arch}.dot ./${binario} > iaca/${binario}.thrput.${arch}.txt   2>&1 && echo "OK"
        # graphviz
        # dot -Tpng iaca/deps.${binario}.thr.${arch}.dot1.dot -o iaca/deps.${binario}.thr.${arch}.png
        # dot -Tpng iaca/deps.${binario}.lat.${arch}.dot1.dot -o iaca/deps.${binario}.lat.${arch}.png
    done
done
    
exit

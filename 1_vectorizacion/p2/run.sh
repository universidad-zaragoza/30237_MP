#!/bin/bash

# uso:
#    ./run.sh -c compilador -f fichero -l vector_len (Kelements) -p precision
# ejemplo
#    ./run.sh -c gcc  -f axpy.c -l 2  -p 0

[ -z "$CPU" ] && echo "Hay que inicializar la variable CPU (source ./init_cpuname.sh)" && exit 1;
[ ! -d "$CPU" ] && echo "No se ha compilado" && exit 1;

# valores por defecto
comp=gcc
# flag march
arch=native
src="triad_align.c"
vlenk=1   # 1K elementos

# floating point precision, 
#    p=0 corresponds to single precision
#    p=1 corresponds to double precision
p=0

while getopts "f:c:a:l:p:h" opt; do
  case $opt in
    f) 
      src=$OPTARG
      ;;
    c) 
      comp=$OPTARG
      ;;
    a) 
      arch=$OPTARG
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

cd ${CPU}
mkdir -p results

binario=${id}.${vlenk}k.${precision}.${arch}.${comp}
if [ ! -f ${binario} ]; then
    echo "No se ha encontrado el fichero ${CPU}/${binario}"
    exit
fi
echo -n "ejecutando ${binario} ... "
./${binario}    > results/${binario}.out    2>&1
echo "OK"

exit

binario=${id}.${vlenk}k.${precision}.avx2.${comp}
if [ ! -f ${binario} ]; then
    echo "No se ha encontrado el fichero ${CPU}/${binario}"
    exit
fi
echo -n "ejecutando ${binario} ... "
./${binario}    > results/${binario}.out    2>&1
echo "OK"

# ejecución de binario generado a partir de ensamblador modificado a mano
#./${binario}.chus  > results/${binario}.chus.out   2>&1

echo "fin"

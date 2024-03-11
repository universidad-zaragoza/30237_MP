#!/bin/bash

# uso:
#    ./run.sh -c compilador -f fichero -l vector_len (Kelements) -p precision -s
# ejemplo
#    ./run.sh -c gcc  -f axpy.c -l 2  -p 0

[ -z "$CPU" ] && echo "Hay que inicializar la variable CPU (source ./init_cpuname.sh)" && exit 1;
[ ! -d "$CPU" ] && echo "No se ha compilado" && exit 1;

# valores por defecto
comp=gcc
src="ss_align.c"
vlenk=1   # 1K elementos
loopalignstr=
PERF=

# floating point precision, 
#    p=0 corresponds to single precision
#    p=1 corresponds to double precision
p=0

# native version
native=0

while getopts "f:c:l:p:na:sh" opt; do
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
    n) 
      # echo "especificada ejecución de versión nativa"
      native=1
      ;;
    s) 
      # echo "especificada ejecución bajo perf"
      PERF="perf stat -d "
      ;;
    h)
      echo "uso:"
      echo "$0 -f fichero  -c compilador"
      echo "ejemplo:"
      echo "$0 -f s000  -c gcc"
      exit
      ;;
    a) 
      # code alignment
      # https://easyperf.net/blog/2018/01/18/Code_alignment_issues
      case ${OPTARG} in
	      *[!0-9]* | '')
	          echo "Los bucles tienen que estar alineados con un número entero positivo"
	          exit
	          ;;
	  esac
      loopalign=${OPTARG}
      loopalignstr=.${OPTARG}loopalign
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

if [ "$native" -eq 1 ]; then
    version_list=(avx2 native)
else
    version_list=(avx2)
fi

# loop over the vector/scalar binaries
for j in "${!version_list[@]}"; do
    binario=${id}.${vlenk}k.${precision}.${version_list[$j]}$loopalignstr.${comp}
    if [ ! -f ${binario} ]; then
        echo "No se ha encontrado el fichero ${CPU}/${binario}"
        continue
    fi
    echo -n "ejecutando ${PERF}${binario} ... "
    # ./${binario} > results/${binario}.out   2>&1 && echo OK
    ${PERF} ./${binario} > results/${binario}.out   2>&1
    if [ $? -eq 0 ]; then
        echo OK
    else
        echo ERROR
    fi
done    

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

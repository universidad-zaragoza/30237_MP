#!/bin/bash

# uso:
#    ./run.sh -c compilador -f fichero -l vector_len (Kelements) -p precision -s
# ejemplo
#    ./run.sh -c gcc  -f scale_shift.c -l 2  -p 0

[ -z "$CPU" ] && echo "Hay que inicializar la variable CPU (source ./init_cpuname.sh)" && exit 1;
[ ! -d "$CPU" ] && echo "No se ha compilado" && exit 1;

# valores por defecto
comp=gcc
src="scale_shift.c"
vlenk=1   # 1K elementos
PERF=

# floating point precision, 
#    p=0 corresponds to single precision
#    p=1 corresponds to double precision
p=0

# native version
native=0

while getopts "f:c:l:p:nsh" opt; do
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
    version_list=(vec.avx vec.avxfma vec.native esc.avx esc.avxfma esc.native)
else
    version_list=(vec.avx vec.avxfma esc.avx esc.avxfma)
fi

# loop over the vector/scalar binaries
for j in "${!version_list[@]}"; do
    binario=${id}.${vlenk}k.${precision}.${version_list[$j]}.${comp}
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

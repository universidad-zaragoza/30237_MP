#!/bin/bash

# uso:
#    ./run.callgrind.sh -c compilador -f fichero -k funcion -l vector_len (Kelements) -p precision
# ejemplo
#    ./run.callgrind.sh -c gcc  -f s000.c -l 2  -p 0

[ -z "$CPU" ] && echo "Hay que inicializar la variable CPU (source ./init_cpuname.sh)" && exit 1;
[ ! -d "$CPU" ] && echo "No se ha compilado" && exit 1;

# valores por defecto
src="triad.c"
fn="triad"
comp=gcc
vlenk=32   # 32K elementos

# floating point precision, 
#    p=0 corresponds to single precision
#    p=1 corresponds to double precision
p=0

while getopts "f:k:c:l:p:h" opt; do
  case $opt in
    f) 
      src=$OPTARG
      ;;
    k) 
      fn=$OPTARG
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
mkdir -p valgrind

version_list=(noavx.omp avx.omp)
nth_list=(1)

# loop over the vector/scalar binaries
for version in "${version_list[@]}"; do

    #./comp.omp.sh -c ${compiler} -f ${src} -l ${vlen}  -p ${precision}
    binario=${id}.${version}.${vlenk}k.${precision}.${comp}

    for nth in "${nth_list[@]}"; do

        export OMP_NUM_THREADS=${nth}

        # callgrind
        echo -n "ejecutando callgrind ./${binario} ... "
        outfile=valgrind/callg.outfile.${binario}.${nth}th.txt
        profile=valgrind/callg.profile.${binario}.${nth}th.txt
        summary=valgrind/callg.summary.${version}.${nth}th.txt

        # --toggle-collect=axpby -> recoge datos de la función axpby()
        VG_OPTS="--tool=callgrind --branch-sim=yes  --toggle-collect=${fn} --callgrind-out-file=${profile}"
        valgrind ${VG_OPTS} ./${binario} > ${outfile} 2>&1
        callgrind_annotate --tree=both --inclusive=yes --auto=yes ${profile} > ${summary}
        echo "OK"

        # cachegrind
        echo -n "ejecutando cachegrind ./${binario} ... "
        outfile=valgrind/cacheg.outfile.${binario}.${nth}th.txt
        profile=valgrind/cacheg.profile.${binario}.${nth}th.txt
        summary=valgrind/cacheg.summary.${binario}.${nth}th.txt

        VG_OPTS="--tool=cachegrind --cachegrind-out-file=${profile}"
        valgrind ${VG_OPTS} ./${binario} > ${outfile} 2>&1
        cg_annotate --auto=yes ${profile} >> ${summary}
        echo "OK"
    done
done    
    
exit

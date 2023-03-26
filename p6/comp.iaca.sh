#!/bin/bash

# uso:
#    ./comp.iaca.sh -c compilador -f fichero -p precision
# ejemplo
#    ./comp.iaca.sh -c gcc  -f s000.c -p 0

[ -z "$CPU" ] && echo "Hay que inicializar la variable CPU (source ./init_cpuname.sh)" && exit 1;
#: ${CPU:?"Hay que inicializar la variable CPU (source ./init_cpuid.sh)"}

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
      echo "$0 -f s000.c  -c gcc"
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

if [ ! -f ${src} ]; then
    echo "No se ha encontrado el fichero ${src}"
    exit
fi
id="${src%.*}"    # extract .c

echo "compilando fichero ${src} con compilador ${comp} y soporte IACA ... "

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

mkdir -p $CPU	# directorio para albergar binarios, ensambladores, informes
cd $CPU
rm -f *.o

mkdir -p assembler
mkdir -p reports

FLAGS="-std=c99 -g -O3 -DPRECISION=$p -DIACA"  # -Ofast -mtune=native
LIBS="-lm"

case $comp in
    gcc | gcc-5 | gcc-6 | gcc-7 | gcc-8 )
        # echo "---------- gcc ---------------------------------------------------------"
        # for gcc > 4.7
        GCC_FLAGS="-Wall"  # GCC_FLAGS="-Q -v"
        VEC_REPORT_FLAG="-fopt-info-vec-optimized"
        # VEC_REPORT_FLAG="-fopt-info-vec-optimized -fopt-info-vec-missed"
        NOVECTOR_FLAG="-fno-tree-vectorize"

        $comp -DPRECISION=$p -c ../dummy.c

        # gcc: -ftree-vectorize se activa con -O3
        # -march=native
        # nota: las compilaciones con -fno-tree-vectorize no generan informe

        # echo "---------- gcc (SSE4.2) ------------------------------------------------"
        # -msse4.2

        # echo "---------- gcc (AVX) ---------------------------------------------------"
        echo -n " gcc noavx ... "
        binario=${id}.noavx.${precision}.${comp}.iaca
        rm -f ${binario}
        $comp  -mavx2   $FLAGS $GCC_FLAGS $NOVECTOR_FLAG      \
               dummy.o ../${src} $LIBS -o ${binario}         \
               > reports/${binario}.report.txt   2>&1
        objdump -Sd ${binario} > assembler/${binario}.s
        echo "OK "

        # echo -n " gcc noavxfma ... "
        # binario=${id}.noavxfma.${precision}.${comp}.iaca
        # rm -f ${binario}
        # $comp  -mavx2 -mfma -ffast-math $FLAGS $GCC_FLAGS $NOVECTOR_FLAG      \
        #        dummy.o ../${src} $LIBS -o ${binario}         \
        #        > reports/${binario}.report.txt   2>&1
        # objdump -Sd ${binario} > assembler/${binario}.s
        # echo "OK "

        # los marcadores insertados impiden la vectorización por parte de gcc
        # https://gcc.gnu.org/bugzilla/show_bug.cgi?id=63467
        # binario=${id}.avx.${precision}.${comp}.iaca
        # rm -f ${binario}
        # $comp  -mavx  $FLAGS $GCC_FLAGS $VEC_REPORT_FLAG    \
        #        dummy.o ../${src} $LIBS -o ${binario}        \
        #        > reports/${binario}.report.txt   2>&1
        # objdump -Sd ${binario} > assembler/${binario}.s
        # echo "OK "

        # Otra opcion para visualizar ensamblador + fuente C
        #       gcc ... -Wa,-adghln=assembler/${id}.avx.${comp}.s    
        # Ensamblador con comentarios (sin fuente)
        #    $ gcc $FLAGS -msse4.2 -fverbose-asm dummy.o ../${src} -o ${id}.sse.gcc.s -S
        ;;

    icc )
        # export PATH=$PATH:/opt/intel/bin
        
        #echo "---------- icc ---------------------------------------------------------"
        VEC_VECTOR_FLAG="-qopt-report-phase=vec"
        NOVECTOR_FLAG="-no-vec"

        icc -DPRECISION=$p -c ../dummy.c
        
        # CUIDADO
        # -m option is used to build for non-Intel processors
        # -x option to build for Intel processors
        # -ax option to generate  multiple,  processor-specific  code paths
        #     if there is a performance benefit. It also generates
        #     a generic IA-32 architecture code path
        
        #echo "---------- icc (SSE4.2) ------------------------------------------------"
        # -xSSE4.2
        
        #echo "---------- icc (AVX) ---------------------------------------------------"
        echo -n " icc noavx ... "
        binario=${id}.noavx.${precision}.${comp}.iaca
        icc  -xCORE-AVX2  $FLAGS  $NOVECTOR_FLAG      \
            dummy.o ../${src} -o ${binario}               \
            -qopt-report-file=stdout > reports/${binario}.report.txt
        icc  -xCORE-AVX2  $FLAGS  $NOVECTOR_FLAG  -S -fsource-asm \
             dummy.o ../${src} -o assembler/${binario}.s

        # binario=${id}.avx.${precision}.${comp}.iaca
        # icc  -xCORE-AVX2  $FLAGS  $VEC_REPORT_FLAG  \
        #     dummy.o ../${src} -o ${binario}              \
        #      -qopt-report-file=stdout  > reports/${binario}.report.txt 2>&1
        # icc  -xCORE-AVX2  $FLAGS  -S -fsource-asm    \
        #      dummy.o ../${src} -o assembler/${binario}.s
        
        #echo "---------- icc (AVX512) -------------------------------------------------"
        #echo "------------------------------------------------------------------------"
        #echo
        ;;

    * )
        echo "compilador no soportado"
        exit 1
        ;;
esac
echo "fin"

#!/bin/bash

# uso:
#    ./comp.omp.sh  -c compilador  -f fichero  -p precision
# ejemplo
#    ./comp.omp.sh  -c gcc  -f axpy.c  -p 0

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

echo "compilando fichero ${src} con vlen ${vlen} y compilador ${comp} ... "

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

FLAGS="-std=gnu99 -g -O3 -DPRECISION=$p -DLEN=$vlen"  # -Ofast -mtune=native
# FLAGS="-std=c99 -g -O3 -DPRECISION=$p -DLEN=$vlen"  # -Ofast -mtune=native
LIBS="-lm"

case $comp in
    gcc | gcc-5 | gcc-6 | gcc-7 | gcc-8 )
        #echo "---------- gcc ---------------------------------------------------------"
        # for gcc > 4.7
        GCC_FLAGS=" " # GCC_FLAGS="-pthread"  # GCC_FLAGS="-Q -v"
        VEC_REPORT_FLAG="-fopt-info-vec-optimized"
        # VEC_REPORT_FLAG="-fopt-info-vec-optimized -fopt-info-vec-missed"

        $comp -DPRECISION=$p -c ../dummy.c

        # gcc: -ftree-vectorize se activa con -O3
        # -march=native
        # nota: las compilaciones con -fno-tree-vectorize no generan informe

        #echo "---------- gcc (SSE4.2) ------------------------------------------------"
        # -msse4.2
        #echo "---------- gcc (AVX) ---------------------------------------------------"
        binario=${id}.avx.${precision}.${comp}.iaca

        # C -> ensamblador
        $comp  -mavx2 -c -S $FLAGS $GCC_FLAGS $VEC_REPORT_FLAG    \
               ../${src} $LIBS -o assembler/${binario}.s  \
                > reports/${binario}.report.txt   2>&1
        # -mavx2 -mfma -ffast-math

        echo "Fichero ensamblador generado: assembler/${binario}.s"
        echo " "
        echo "Añade los marcadores IACA_START e IACA_END al inicio y final del bucle a analizar"
        echo "IACA_START"
        echo "    mov    $0x6f,%ebx"
        echo "    fs addr32 nop"
        echo "IACA_END"
        echo "    mov    $0xde,%ebx"
        echo "    fs addr32 nop"
        echo " "
        read -n1 -r -p "Una vez añadidos, pulsa una tecla para continuar..."
        # ensamblador -> objeto
        $comp  -mavx2  -c $FLAGS $GCC_FLAGS $VEC_REPORT_FLAG    \
               assembler/${binario}.s -o ${binario}.o
        # montaje final: objetos -> binario
        $comp  -mavx2  $FLAGS $GCC_FLAGS $VEC_REPORT_FLAG    \
               dummy.o ${binario}.o $LIBS -o ${binario}
        ;;

    icc )
        # export PATH=$PATH:/opt/intel/bin
        
        #echo "---------- icc ---------------------------------------------------------"
        ICC_FLAGS=" "
        VEC_VECTOR_FLAG="-qopt-report-phase=vec"

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
        binario=${id}.avx.${precision}.${comp}.iaca

        # C -> ensamblador
        $comp  -xCORE-AVX2  $FLAGS  -S  \
               ../${src} -o assembler/${binario}.s
               -qopt-report-file=stdout  > reports/${binario}.report.txt 2>&1

        echo "Fichero ensamblador generado: assembler/${binario}.s"
        echo " "
        echo "Añade los marcadores IACA al inicio y final del bucle a analizar"
        echo "IACA_START"
        echo "    mov    $0x6f,%ebx"
        echo "    fs addr32 nop"
        echo "IACA_END"
        echo "    mov    $0xde,%ebx"
        echo "    fs addr32 nop"
        echo " "
        read -n1 -r -p "Una vez añadidos, pulsa una tecla para continuar..."
        # ensamblador -> objeto
        $comp  -xCORE-AVX2  -c $FLAGS $ICC_FLAGS $VEC_REPORT_FLAG    \
               assembler/${binario}.s -o ${binario}.o
        # montaje final: objetos -> binario
        $comp  -xCORE-AVX2  $FLAGS $ICC_FLAGS $VEC_REPORT_FLAG    \
               dummy.o ${binario}.o $LIBS -o ${binario}

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

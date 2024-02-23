#!/bin/bash

# uso:
#    ./comp.sh -c compilador -f fichero -l vector_len (Kelements) -p precision
# ejemplo
#    ./comp.sh -c gcc  -f axpy.c -l 2  -p 0

[ -z "$CPU" ] && echo "Hay que inicializar la variable CPU (source ./init_cpuname.sh)" && exit 1;
#: ${CPU:?"Hay que inicializar la variable CPU (source ./init_cpuid.sh)"}

# valores por defecto
comp=gcc
vlenk=1   # 1K elements
vlen=$((vlenk*1024))
DEFINES=

# floating point precision, 
#    p=0 corresponds to single precision
#    p=1 corresponds to double precision
p=0

# native version
native=0

while getopts "f:c:l:p:nT:h" opt; do
  case $opt in
    f) 
      # echo "especificado fichero -> $OPTARG"
      src=$OPTARG
      ;;
    c) 
      # echo "especificado compilador -> $OPTARG"
      comp=$OPTARG
      ;;
    l) 
      # echo "especificada longitud de vectores -> $OPTARG"
      # https://stackoverflow.com/a/18620446/1037634
      case ${OPTARG} in
	      *[!0-9]* | '')
	          echo "La longitud de los vectores debe ser un número entero positivo"
	          exit
	          ;;
	  esac
      vlenk=$OPTARG
      vlen=$((vlenk*1024))U
      DEFINES="${DEFINES} -DLEN=$vlen"
      ;;
    p) 
      # echo "especificado precision -> $OPTARG"
      p=$OPTARG
      ;;
    n) 
      # echo "especificada compilación nativa"
      native=1
      ;;
    T) 
      # echo "especificado NTIMES -> $OPTARG"
      # https://stackoverflow.com/a/18620446/1037634
      case ${OPTARG} in
	      *[!0-9]* | '')
	          echo "El número de repeticiones debe ser un número entero positivo"
	          exit
	          ;;
	  esac
      NTIMES=${OPTARG}UL
      DEFINES="${DEFINES} -DNTIMES=${NTIMES}"
      ;;
    h)
      echo "uso:"
      echo "$0 -f fichero  -c compilador"
      echo "ejemplo:"
      echo "$0 -f ss_align.c -c gcc -l 1  -p 0"
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

if [ -z "${src}" ] ; then
    echo "No se ha especificado fichero fuente"
    echo "ejemplo:"
    echo "$0 -f s000.c"
    exit
fi
if [ ! -f ${src} ]; then
    echo "No se ha encontrado el fichero ${src}"
    exit
fi
id="${src%.*}"    # extract .c

echo -e "compilando fichero ${src} con vlen ${vlen} y compilador ${comp} ... \n"

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

FLAGS="-std=c11 -g -O3 -DPRECISION=$p"
FLAGS="${FLAGS} ${DEFINES}"
LIBS="-lm"

case $comp in
    gcc | gcc-7 | gcc-8 | gcc-9 | gcc-10 | gcc-11 | gcc-12)
        # echo "---------- gcc ---------------------------------------------------------"
        # for gcc > 4.7
        GCC_FLAGS=" -Wall -Wextra -Wshadow"  # GCC_FLAGS="-Q -v"
        VEC_REPORT_FLAG="-fopt-info-vec-optimized -fopt-info-loop-optimized"
        # VEC_REPORT_FLAG="-fopt-info-vec-optimized -fopt-info-vec-missed"
        NOVECTOR_FLAG="-fno-tree-vectorize"
        EXTRA_FLAGS=""

        if [ ${id} = "ss_stride" ]; then
           EXTRA_FLAGS="-mfma -ffast-math"
        fi

        $comp -DPRECISION=$p -c ../dummy.c

        # gcc: -ftree-vectorize se activa con -O3
        # -march=native
        # nota: las compilaciones con -fno-tree-vectorize no generan informe

        #echo "---------- gcc (AVX) ---------------------------------------------------"
        echo "gcc avx2 ... "
        binario=${id}.${vlenk}k.${precision}.avx2.${comp}
        rm -f ${binario}
        $comp  -mavx2 $FLAGS $GCC_FLAGS $EXTRA_FLAGS  $VEC_REPORT_FLAG    \
                dummy.o ../${src} $LIBS -o ${binario}        \
                2>&1  | tee reports/${binario}.report.txt
        objdump -Sd ${binario} > assembler/${binario}.s
        echo -e "OK\n"

        # echo "---------- gcc (native) ---------------------------------------------------"
        if [ "$native" -eq 1 ]; then
            echo "gcc native ... "
            binario=${id}.${vlenk}k.${precision}.native.${comp}
            rm -f ${binario}
            $comp  -march=native  $FLAGS $GCC_FLAGS $EXTRA_FLAGS  $VEC_REPORT_FLAG    \
                   dummy.o ../${src} $LIBS -o ${binario}        \
                   2>&1  | tee reports/${binario}.report.txt
            objdump -Sd ${binario} > assembler/${binario}.s
            echo -e "OK\n"
        fi

        # xeon phi
        # $comp  -march=knl -DPRECISION=$p $FLAGS $GCC_FLAGS $VEC_REPORT_FLAG  \
        #       dummy.o ../${src} $LIBS -o ${id}.avx512.${comp}                    \
        #       -Wa,-adghln=assembler/${id}.avx512.${comp}.s  > reports/${id}.avx512.${comp}.report.txt   2>&1

        # generación de código ensamblador limpio
        # $comp  -march=native -DPRECISION=$p $FLAGS $GCC_FLAGS $VEC_REPORT_FLAG  \
        #       ../${src} $LIBS -S -o assembler/${id}.avx.${comp}.clean.s  > reports/${id}.avx.${comp}.clean.report.txt   2>&1
        
        # generación de binario a partir de ensamblador modificado a mano
        # $comp  -march=native -DPRECISION=$p $FLAGS $GCC_FLAGS $VEC_REPORT_FLAG  \
        #       dummy.o assembler/${id}.avx.${comp}.chus.s $LIBS -o ${id}.avx.${comp}.chus  > reports/${id}.avx.${comp}.chus.report.txt   2>&1
        ;;

    icx )
        # export PATH=$PATH:/opt/intel/bin
        
        #echo "---------- icc ---------------------------------------------------------"
        ICX_FLAGS=" "
        # ICX_FLAGS="-unroll0"
        VEC_REPORT_FLAG=" "
        # VEC_REPORT_FLAG="-qopt-report-phase=vec"
        NOVECTOR_FLAG="-no-vec"

        icx -DPRECISION=$p -c ../dummy.c
        
        # CUIDADO
        # -m option is used to build for non-Intel processors
        # -x option to build for Intel processors
        # -ax option to generate  multiple,  processor-specific  code paths
        #     if there is a performance benefit. It also generates
        #     a generic IA-32 architecture code path
        
        #echo "---------- icc (AVX) ---------------------------------------------------"
        binario=${id}.${vlenk}k.${precision}.avx2.${comp}

        icx  -xCORE-AVX2  -vec-threshold0 $FLAGS $ICX_FLAGS  $VEC_REPORT_FLAG  \
             dummy.o ../${src} -o ${binario}              \
             -qopt-report-file=stdout > reports/${binario}.report.txt 2>&1
        icx  -xCORE-AVX2  -vec-threshold0 $FLAGS $ICX_FLAGS  -S -fsource-asm   \
             dummy.o ../${src} -o assembler/${binario}.s > /dev/null  2>&1

        # icx  -xHost $FLAGS $ICX_FLAGS  $VEC_REPORT_FLAG  \
        #     dummy.o ../${src} -o ${binario}              \
        #     -qopt-report-file=stdout > reports/${binario}.report.txt 2>&1
        # icx -xHost $FLAGS $ICX_FLAGS  -S -fsource-asm   \
        #     dummy.o ../${src} -o assembler/${binario}.s > /dev/null  2>&1
        
        # icx  -xHost -DPRECISION=$p $FLAGS $ICX_FLAGS  $NOVECTOR_FLAG  \
        #      dummy.o ../${src} -o ${id}.noavx.icc                         \
        #      -qopt-report-file=stdout > reports/${id}.noavx.icc.report.txt
        # icx -xHost -DPRECISION=$p $FLAGS $ICX_FLAGS  $NOVECTOR_FLAG  -S -fsource-asm \
        #       dummy.o ../${src} -o assembler/${id}.noavx.icc.s
        echo -e "OK\n"
        ;;

    * )
        echo "compilador no soportado"
        exit 1
        ;;
esac
echo "fin"

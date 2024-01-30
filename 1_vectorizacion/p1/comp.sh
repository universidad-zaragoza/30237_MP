#!/bin/bash

# uso:
#    ./comp.sh -c compilador -f fichero -l vector_len (Kelements) -p precision -T repeticiones_bucle
# ejemplo
#    ./comp.sh -c gcc  -f triad.c -l 2  -p 0

[ -z "$CPU" ] && echo "Hay que inicializar la variable CPU (source ./init_cpuname.sh)" && exit 1;
#: ${CPU:?"Hay que inicializar la variable CPU (source ./init_cpuid.sh)"}

# valores por defecto
comp=gcc
src="scale_shift.c"
vlenk=1   # 1K elements
# vlenk=64   # 64K elements
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
      echo "$0 -c gcc -f scale_shift.c -l 1  -p 0"
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

FLAGS="-std=c11 -g -O3 -DPRECISION=$p"  # -Ofast -mtune=native
# FLAGS="-std=c11 -g -O3 -DPRECISION=$p -DLEN=$vlen"  # -Ofast -mtune=native
# FLAGS="-std=c11 -g -O3 -DPRECISION=$p -DLEN=$vlen -gdwarf-3 -gstrict-dwarf"  # -Ofast -mtune=native
FLAGS="${FLAGS} ${DEFINES}"
LIBS="-lm"

case $comp in
    gcc | gcc-9 | gcc-10 | gcc-11 | gcc-12)
        # echo "---------- gcc ---------------------------------------------------------"
        # for gcc > 4.7
        GCC_FLAGS=" -Wall -Wextra -Wshadow"  # GCC_FLAGS="-Q -v"
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
        echo "gcc vectorial avx ... "
        binario=${id}.${vlenk}k.${precision}.vec.avx.${comp}
        rm -f ${binario}
        $comp  -mavx2  $FLAGS $GCC_FLAGS $VEC_REPORT_FLAG    \
               dummy.o ../${src} $LIBS -o ${binario}        \
               2>&1 | tee reports/${binario}.report.txt
        objdump -Sd ${binario} > assembler/${binario}.s
        echo -e "OK\n"

        echo "gcc escalar avx ... "
        binario=${id}.${vlenk}k.${precision}.esc.avx.${comp}
        rm -f ${binario}
        $comp  -mavx2  $FLAGS $GCC_FLAGS $NOVECTOR_FLAG      \
               dummy.o ../${src} $LIBS -o ${binario}        \
               2>&1  | tee reports/${binario}.report.txt
        objdump -Sd ${binario} > assembler/${binario}.s
        echo -e "OK\n"

        # echo "---------- gcc (AVX+FMA) ---------------------------------------------------"
        echo "gcc vectorial avx+fma ... "
        binario=${id}.${vlenk}k.${precision}.vec.avxfma.${comp}
        rm -f ${binario}
        $comp  -mavx2  -mfma -ffast-math  $FLAGS $GCC_FLAGS $VEC_REPORT_FLAG    \
               dummy.o ../${src} $LIBS -o ${binario}        \
               2>&1  | tee reports/${binario}.report.txt
        objdump -Sd ${binario} > assembler/${binario}.s
        echo -e "OK\n"

        echo "gcc escalar avx+fma ... "
        binario=${id}.${vlenk}k.${precision}.esc.avxfma.${comp}
        rm -f ${binario}
        $comp  -mavx2  -mfma -ffast-math  $FLAGS $GCC_FLAGS $NOVECTOR_FLAG    \
               dummy.o ../${src} $LIBS -o ${binario}        \
               2>&1  | tee reports/${binario}.report.txt
        objdump -Sd ${binario} > assembler/${binario}.s
        echo -e "OK\n"

        # echo "---------- gcc (AVX512) ---------------------------------------------------"
        # AVX-512 Vector Length EVEX feature: -mavx512vl (Skylake)
        # -mavx512f -mavx512pf -mavx512er -mavx512cd
        echo "gcc vectorial avx512... "
        binario=${id}.${vlenk}k.${precision}.vec.avx512.${comp}
        rm -f ${binario}
        $comp  -mavx512vl  $FLAGS $GCC_FLAGS $VEC_REPORT_FLAG   \
               dummy.o ../${src} $LIBS -o ${binario}            \
               2>&1  | tee reports/${binario}.report.txt
        objdump -Sd ${binario} > assembler/${binario}.s
        echo -e "OK\n"

        echo "gcc escalar avx512... "
        binario=${id}.${vlenk}k.${precision}.esc.avx512.${comp}
        rm -f ${binario}
        $comp  -mavx512vl   $FLAGS $GCC_FLAGS $NOVECTOR_FLAG    \
               dummy.o ../${src} $LIBS -o ${binario}            \
               2>&1  | tee reports/${binario}.report.txt
        objdump -Sd ${binario} > assembler/${binario}.s
        echo -e "OK\n"

        # echo "---------- gcc (native) ---------------------------------------------------"
        if [ "$native" -eq 1 ]; then
            echo "gcc vectorial native ... "
            binario=${id}.${vlenk}k.${precision}.vec.native.${comp}
            rm -f ${binario}
            $comp  -march=native  $FLAGS $GCC_FLAGS $VEC_REPORT_FLAG    \
                   dummy.o ../${src} $LIBS -o ${binario}        \
                   2>&1  | tee reports/${binario}.report.txt
            objdump -Sd ${binario} > assembler/${binario}.s
            echo -e "OK\n"

            echo "gcc escalar native ... "
            binario=${id}.${vlenk}k.${precision}.esc.native.${comp}
            rm -f ${binario}
            $comp  -march=native  $FLAGS $GCC_FLAGS $NOVECTOR_FLAG      \
                   dummy.o ../${src} $LIBS -o ${binario}        \
                   2>&1  | tee reports/${binario}.report.txt
            objdump -Sd ${binario} > assembler/${binario}.s
            echo -e "OK\n"
        fi

        # Otra opcion para visualizar ensamblador + fuente C
        #       gcc ... -Wa,-adghln=assembler/${binario}.s    
        # Ensamblador con comentarios (sin fuente)
        #    $ gcc $FLAGS -msse4.2 -fverbose-asm dummy.o ../${src} -o ${id}.sse.gcc.s -S
        ;;

    icc )
        # export PATH=$PATH:/opt/intel/bin
        
        #echo "---------- icc ---------------------------------------------------------"
        VEC_REPORT_FLAG="-qopt-report-phase=vec"
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
        # -xAVX
        echo "gcc vectorial avx... "
        binario=${id}.${vlenk}k.${precision}.vec.avx.${comp}
        rm -f ${binario}
        icc  -xCORE-AVX2  $FLAGS  $VEC_REPORT_FLAG  \
             dummy.o ../${src} -o ${binario}              \
             -qopt-report-file=stdout  | tee  reports/${binario}.report.txt 2>&1
        icc  -xCORE-AVX2  $FLAGS  -S -fsource-asm    \
             dummy.o ../${src} -o assembler/${binario}.s

        echo "gcc escalar avx ... "
        binario=${id}.${vlenk}k.${precision}.esc.avx.${comp}
        rm -f ${binario}
        icc  -xCORE-AVX2  $FLAGS  $NOVECTOR_FLAG      \
            dummy.o ../${src} -o ${binario}               \
            -qopt-report-file=stdout | tee  reports/${binario}.report.txt
        icc  -xCORE-AVX2  $FLAGS  $NOVECTOR_FLAG  -S -fsource-asm \
             dummy.o ../${src} -o assembler/${binario}.s
        
        #echo "---------- icc (AVX512) -------------------------------------------------"
        echo "gcc vectorial avx512... "
        binario=${id}.${vlenk}k.${precision}.vec.avx512.${comp}
        rm -f ${binario}
        # -xCORE-AVX512
        icc  -xCORE-AVX512 -qopt-zmm-usage=high $FLAGS  $VEC_REPORT_FLAG  \
             dummy.o ../${src} -o ${binario}              \
             -qopt-report-file=stdout  | tee  reports/${binario}.report.txt 2>&1
        icc  -xCORE-AVX512 -qopt-zmm-usage=high $FLAGS  -S -fsource-asm    \
             dummy.o ../${src} -o assembler/${binario}.s

        echo "gcc escalar avx512... "
        binario=${id}.${vlenk}k.${precision}.esc.avx512.${comp}
        rm -f ${binario}
        icc  -xCORE-AVX512 -qopt-zmm-usage=high $FLAGS  $NOVECTOR_FLAG      \
            dummy.o ../${src} -o ${binario}               \
            -qopt-report-file=stdout | tee  reports/${binario}.report.txt
        icc  -xCORE-AVX512 -qopt-zmm-usage=high $FLAGS  $NOVECTOR_FLAG  -S -fsource-asm \
             dummy.o ../${src} -o assembler/${binario}.s
        #echo "------------------------------------------------------------------------"
        #echo
        ;;

    clang-8 )
        # echo "---------- gcc ---------------------------------------------------------"
        # for gcc > 4.7
        CLANG_FLAGS=" "
        VEC_REPORT_FLAG="-fsave-optimization-record"
        NOVECTOR_FLAG="-fno-vectorize"

        $comp -DPRECISION=$p -c ../dummy.c

        # gcc: -ftree-vectorize se activa con -O3
        # -march=native
        # nota: las compilaciones con -fno-tree-vectorize no generan informe

        # echo "---------- gcc (SSE4.2) ------------------------------------------------"
        # -msse4.2

        # echo "---------- gcc (AVX) ---------------------------------------------------"

        # echo "---------- gcc (AVX) ---------------------------------------------------"
        echo "clang vectorial avx ... "
        binario=${id}.${vlenk}k.${precision}.vec.avx.${comp}
        rm -f ${binario}
        $comp  -mavx2  $FLAGS $CLANG_FLAGS $VEC_REPORT_FLAG    \
               dummy.o ../${src} $LIBS -o ${binario}        \
               2>&1 | tee reports/${binario}.report.txt
        objdump -Sd ${binario} > assembler/${binario}.s
        echo -e "OK\n"

        echo "gcc escalar avx ... "
        binario=${id}.${vlenk}k.${precision}.esc.avx.${comp}
        rm -f ${binario}
        $comp  -mavx2  $FLAGS $CLANG_FLAGS $NOVECTOR_FLAG      \
               dummy.o ../${src} $LIBS -o ${binario}        \
               2>&1  | tee reports/${binario}.report.txt
        objdump -Sd ${binario} > assembler/${binario}.s
        echo -e "OK\n"
        #echo "------------------------------------------------------------------------"
        #echo
        ;;


    * )
        echo "compilador no soportado"
        exit 1
        ;;
esac
echo "fin"

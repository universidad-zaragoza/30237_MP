#!/bin/bash

# uso:
#    ./run.sh -c compilador -f fichero -l vector_len (Kelements) -p precision
# ejemplo
#    ./run.sh -c gcc  -f scale_shift.c -l 2  -p 0

[ -z "$CPU" ] && echo "Hay que inicializar la variable CPU (source ./init_cpuname.sh)" && exit 1;
[ ! -d "$CPU" ] && echo "No se ha compilado" && exit 1;

# valores por defecto
comp=gcc
src="scale_shift.c"
vlenk=1   # 1K elementos

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
mkdir -p sde

SDE_PATH=/usr/local/intel/sde-external
# SDE_PATH=$HOME/sde-external-8.16.0-2018-01-30-lin
#sudo $SDE_PATH/ptrace_scope.sh

# version_list=(avx)
version_list=(esc.avx vec.avx vec.avxfma vec.avx512)
# version_list=(esc.avx esc.avx512 vec.avx vec.avxfma vec.avx512)

# loop over the vector/scalar binaries
for j in "${!version_list[@]}"; do
    binario=${id}.${vlenk}k.${precision}.${version_list[$j]}.${comp}
    outfile=sde/${binario}.sde.mix.txt
    tmpfile=${binario}.sde.mix.tmp
    rm -f ${outfile}
    echo -n "ejecutando $SDE_PATH/sde64 -skx -iform 1 -omix ${outfile} -top_blocks 100 -- ./${binario} ... "

    $SDE_PATH/sde64 -skx -iform 1 -omix ${outfile} -top_blocks 20 -- ./${binario} > $tmpfile 2>&1 && echo OK
    # -skx: set chip-check and CPUID for Intel Skylake server.
    # -mix:  run mix histogram tool
    # -omix: set the output file name for mix. Implies -mix. Default is "mix.out".
    # -iform: to generate the instruction mix histograms by instruction form.
    #         The other option is opcode (XED iclass, the default).
    # -top_blocks: [default 20] specify a maximal number of top blocks for which
    #              icounts are printed

    echo >> $outfile
    echo "#########################################################################" >> $outfile
    echo "# start_output" >> $outfile
    echo "#########################################################################" >> $outfile
    echo
    cat $tmpfile >> $outfile
    echo "# end_output" >> $outfile
    rm $tmpfile
done    
    
exit


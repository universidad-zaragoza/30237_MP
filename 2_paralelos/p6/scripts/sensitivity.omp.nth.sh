#!/bin/bash

# generate one file for each version of code (000,001 ... 111)
#
# this is the layout of the grep-generated file
# (for each loop_len, for each_solvent)
#
# solvent_1  val	(loop_len  8)
# solvent_2  val
#    ...
# solvent_n  val
# solvent_1  val	(loop_len  16)
# solvent_2  val
#    ...
# solvent_n  val
#    ...
# CAREFUL: grep results are only correct
# if files are correctly ordered by loop_len
# (same number of digits for loop_len)

[ -z "$CPU" ] && echo "Hay que inicializar la variable CPU (source ./init_cpuname.sh)" && exit 1;
#: ${CPU:?"Hay que inicializar la variable CPU (source ./init_cpuid.sh)"}

# valores por defecto

cd $CPU

directory="results"
if [ ! -d "$directory" ]; then
  echo "Directory $directory does not exist"
  exit 1
fi

# loop id
loop="s001"

# compilers
compiler_list=(gcc-5)
#compiler_list=(gcc-5 gcc-6)

# list of functions to analyze
function_list=("avx.omp" "noavx.omp")
#function_list=("avx.omp" "avx.noomp" "noavx.omp" "noavx.noomp")

# SP/DP
precision_list=(single)
#precision_list=(single double)

# starts at 2 because the first field returned by grep is the filename
metric_list=(3)

vlen=32k

# let's go
for compiler in "${compiler_list[@]}"; do

    # loop over the versions
    for function in "${function_list[@]}"; do
    
        # loop over the precision
        for precision in "${precision_list[@]}"; do
    
            # loop over the metrics
            for metric in "${metric_list[@]}"; do
                outfile=${directory}/data/sensitivity.nth.${loop}.${function}.${vlen}.${precision}.${compiler}.txt
                mkdir -p "${outfile%/*}"
                # sort -V: natural sort of numbers within text
                grep --with-filename -w "${loop}" ${directory}/${loop}.${function}.${vlen}.${precision}.${compiler}* | sort -V | awk -v var="${metric}" '{ print $var }' > ${outfile}
            done
        done
    done
done

exit

################
for i in "${!array[@]}"
do
  echo "key  : $i"
  echo "value: ${array[$i]}"
done

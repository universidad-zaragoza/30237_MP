#!/bin/bash
matlab -nodisplay -nosplash  -r \ 
      "try, run('/home/chus/cap/2_practicas/2_Memoria_Compartida/4_openmp_simd/sensitivity_omp_nth_len.m'), catch, exit(1), end, exit(0);"
echo "matlab exit code: $?"

#matlab -nodisplay -nojvm -nosplash -nodesktop -r \ 
#      "try, run('/home/chus/cap/2_practicas/2_Memoria_Compartida/4_openmp_simd/sensitivity_omp_nth.m'), catch, exit(1), end, exit(0);"
#echo "matlab exit code: $?"

rm $1.omp.details
rm $1.omp.omp.all
g++ -mcmodel=large -O3 -fopenmp -fdump-tree-optimized-details=$1.omp.details -fopt-info-omp-all=$1.omp.omp.all  $1.cpp -o $1omp.bin

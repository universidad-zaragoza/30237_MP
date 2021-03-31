rm $1.noomp.details
rm $1.noomp.omp.all
g++ -mcmodel=large -O3 -floop-parallelize-all -ftree-parallelize-loops=4 -fdump-tree-optimized-details=$1.noomp.details -fopt-info-optimized-optall=$1.noomp.omp.all  $1.cpp -o $1noomp.bin

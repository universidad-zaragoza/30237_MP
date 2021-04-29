rm $1.noomp.details
rm $1.noomp.omp.all
g++ -mcmodel=large -O3 -fdump-tree-optimized-details=$1.noomp.details -fopt-info-omp-all=$1.noomp.omp.all  $1.cpp -o $1noomp.bin

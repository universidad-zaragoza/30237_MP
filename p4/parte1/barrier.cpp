/* barrier.cpp */
#include <omp.h>
#include <iostream>

const unsigned int DIM = 12;
double A[DIM], B[DIM], C[DIM], D[DIM];

int main(void){
  int l;
  int nthreads, tnumber;

  #pragma omp parallel shared (l) private(nthreads, tnumber)
  {
    nthreads = omp_get_num_threads();
    tnumber  = omp_get_thread_num();
    
    #pragma omp master
    {
      std::cout << "Escribe un valor:" << std::endl;
      std::cin >> l;
    }

    #pragma omp barrier

    #pragma omp critical
    {
      std::cout << "Mi numero de thread es: " << tnumber << std::endl;
      std::cout << "Numero de threads: " << nthreads << std::endl;
      std::cout << "Valor de L es: " << l << std::endl;
    }
  }  
}

/* reduccion.cpp */
#include <omp.h>
#include <iostream>

int main(void){
  int i,j,k;
  int nthreads, tnumber;

  #pragma omp parallel private(tnumber) reduction(+:i) reduction (*:j) reduction (max:k)
  {
    tnumber = omp_get_thread_num();

    i = tnumber;
    j = tnumber;
    k = tnumber;

    std::cout << "Thread " + std::to_string(tnumber) + " I = " + std::to_string(i) + " J = " + std::to_string(j) + " K = " + std::to_string(k) << std::endl;

  }

  std::cout << "Thread " << tnumber << " I = " << i << " J = " << j << " K = " << k << std::endl;

}

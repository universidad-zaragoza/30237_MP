/* parallel2.cpp */
#include <omp.h>
#include <iostream>

int main(void){
  int i;

  #pragma omp parallel private(i)
  {
    i = omp_get_thread_num();
    if (i == 0)
      std::cout << "Soy el master thread (tid = " + std::to_string(i) + ")" << std::endl;
    else
      std::cout << "Soy el thread con tid " + std::to_string(i) << std::endl;
  }
  
  return 0;
}

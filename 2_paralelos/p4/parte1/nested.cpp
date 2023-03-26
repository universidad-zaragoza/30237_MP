/* nested.cpp */
#include <omp.h>
#include <iostream>

int main(void){
  int i;
  int nthreads, tnumber;

  omp_set_dynamic(true);
  //omp_set_max_active_levels(1);  // Sin anidamiento
  //omp_set_max_active_levels(5);  // Hasta 5 niveles de anidamiento
  omp_set_num_threads(2);

  #pragma omp parallel private(nthreads, tnumber)
  {
    tnumber = omp_get_thread_num();
    std::cout << "Primera región paralela: thread " + std::to_string(tnumber) + " de " + std::to_string(omp_get_num_threads()) << std::endl;

    omp_set_num_threads(4);

    #pragma omp parallel firstprivate(tnumber)
    {
      std::cout << "Región anidada paralela (Equipo " + std::to_string(tnumber) + "): thread " + std::to_string(omp_get_thread_num()) + " de " + std::to_string(omp_get_num_threads()) << std::endl;
    }
  }
  return 0;
}

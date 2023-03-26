/* fordir.cpp */
#include <omp.h>
#include <iostream>
#include <random>
#include <algorithm>


unsigned const int DIM = 16;
double A[DIM], B[DIM], s;


int main(void){
  int i;
  int nthreads, tnumber;

  std::random_device rd;  // Se utilizará para sembrar el generador de aleatorios
  std::mt19937 gen(rd()); // Sembrado de  mersenne_twister_engine con rd()
  std::uniform_real_distribution<> dis(0.0, 100.0); //Configuración del espacio de de generación

  for (int n = 0; n < DIM; ++n) {
    A[n] = dis(gen);
    B[n] = dis(gen);
  }

  #pragma omp parallel private(nthreads,tnumber) shared(A,B)
  {
    #pragma omp for schedule (static,4)
    for (int n = 2; n < DIM; n++){
      B[n] = (A[n] - A[n-1]) / 2.0;
      nthreads = omp_get_num_threads();
      tnumber = omp_get_thread_num();
      std::cout << "Thread-" + std::to_string(tnumber) + " de " + std::to_string(nthreads) + " tiene N=" + std::to_string(n) << std::endl;
    } 
    
  }

  s = *std::max_element(B, B+DIM);
  auto l = std::max_element(B, B+DIM);
  
  std::cout << "Máximo gradiente: " << std::to_string(s) << " posicion: " << (l-B) << std::endl;

}

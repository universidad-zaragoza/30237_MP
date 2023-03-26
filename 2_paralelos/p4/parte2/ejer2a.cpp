/* ejer2a.cpp */
#include <omp.h>
#include <iostream>
#include <random>

const int64_t N = 4000000000;

int main(void){
  int nthreads, tnumber;

  double *A = new double[N];
  double *B = new double[N];
  double *C = new double[N];

  std::random_device rd;  // Se utilizará para sembrar el generador de aleatorios
  std::mt19937 gen(78); // Sembrado de  mersenne_twister_engine con rd()
  						// se fija el valor de la semilla para asegurar 
						// replicabilidad en los experimentos
  //std::mt19937 gen(rd()); // Sembrado de  mersenne_twister_engine con rd()
  std::uniform_real_distribution<> dis(0.0, 100.0); //Configuración del espacio de de generación

  for (int64_t i = 0; i < N; ++i) {
    A[i] = dis(gen);
    B[i] = dis(gen);
    C[i] = 0.0;
  }
  
  for (int64_t i = 0; i < N; ++i) {
    A[i] = A[i] + B[i]/2.0;
  }
  

  for (int64_t i=0 ; i < (N/2)-1; ++i){
    A[2*i] = B[i];
    C[2*i] = A[2*i];
    C[2*i + 1] = A[2*i + 1];
  }
  
  std::cout << "A[150]=" << A[150] << " B[150]=" << B[150] << "C[150]=" << C[150] << std::endl;
}

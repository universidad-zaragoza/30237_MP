/* ejer4a.cpp */
#include <omp.h>
#include <iostream>
#include <random>

const int64_t N = 4000000000;

int main(void){
  int nthreads, tnumber;
  int64_t i, j;

  std::random_device rd;  // Se utilizará para sembrar el generador de aleatorios
  std::mt19937 gen(rd()); // Sembrado de  mersenne_twister_engine con rd()
  std::uniform_real_distribution<> dis(0.0, 100.0); //Configuración del espacio de de generación

  double *A = new double[N];
  double *B = new double[N];

  for (i = 0; i < N; ++i) {
    A[i] = dis(gen);
  }

  j = 0;

  for (i = 0; i < ((N/2)-1); ++i) {
    j = j + 2;
    B[j] = A[i];
  }
   
  std::cout << "B[152]=" << B[152] << " A[150]=" << A[150] << std::endl;

}

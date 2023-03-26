/* ejer5.cpp */
#include <omp.h>
#include <iostream>
#include <random>

const unsigned int N = 4000000000;
double q;

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
    B[i] = dis(gen);
  }

  for (i = 0; i < N; ++i) {
    A[i] = A[i] + B[i];
    q = q + A[i];
  }  
 
  std::cout << "B[150]=" << B[150] << " A[150]=" << A[150] << " q=" << q << std::endl;

}


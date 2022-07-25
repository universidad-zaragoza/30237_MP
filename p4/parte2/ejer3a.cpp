/* ejer3a.cpp */
#include <omp.h>
#include <iostream>
#include <random>
#include <math.h>

const int64_t N = 4000000000;

int main(void){
  int nthreads, tnumber;
  double t;
  std::random_device rd;  // Se utilizará para sembrar el generador de aleatorios
  std::mt19937 gen(rd()); // Sembrado de  mersenne_twister_engine con rd()
  std::uniform_real_distribution<> dis(0.0, 100.0); //Configuración del espacio de de generación

  double *A = new double[N];
  double *B = new double[N];
  double *C = new double[N];

  for (int64_t i = 0; i < N; ++i) {
    A[i] = dis(gen);
  }
  
  for (int64_t i = 1; i < N; ++i) {
    t = A[i];
    B[i] = t + pow(t, 2);
    C[i] = t + 2.0;
  }
  
  std::cout << "B[150]=" << B[150] << "C[150]=" << C[150] << "A[150]=" << A[150] << std::endl;

}

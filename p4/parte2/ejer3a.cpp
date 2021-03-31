/* ejer3a.cpp */
#include <omp.h>
#include <iostream>
#include <random>
#include <math.h>

const unsigned int N = 1000000;
double A[N], B[N], C[N];

int main(void){
  int nthreads, tnumber;
  double t;
  std::random_device rd;  // Se utilizará para sembrar el generador de aleatorios
  std::mt19937 gen(rd()); // Sembrado de  mersenne_twister_engine con rd()
  std::uniform_real_distribution<> dis(0.0, 100.0); //Configuración del espacio de de generación

  for (int i = 0; i < N; ++i) {
    A[i] = dis(gen);
  }
  
  for (int i = 1; i < N; ++i) {
    t = A[i];
    B[i] = t + pow(t, 2);
    C[i] = t + 2.0;
  }
  
  std::cout << "B[150]=" << B[150] << "C[150]=" << C[150] << "A[150]=" << A[150] << std::endl;

}

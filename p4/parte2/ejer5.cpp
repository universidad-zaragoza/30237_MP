/* ejer5.cpp */
#include <omp.h>
#include <iostream>
#include <random>

const unsigned int N = 1000000;
double A[N], B[N], q;

int main(void){
  int nthreads, tnumber;
  int i, j;

  std::random_device rd;  // Se utilizará para sembrar el generador de aleatorios
  std::mt19937 gen(rd()); // Sembrado de  mersenne_twister_engine con rd()
  std::uniform_real_distribution<> dis(0.0, 100.0); //Configuración del espacio de de generación

  for (i = 0; i < N; ++i) {
    A[i] = dis(gen);
    B[i] = dis(gen);
  }

  j = 0;

  for (int i = 0; i < N; ++i) {
    A[i] = A[i] + B[i];
    q = q + A[i];
  }  
 
  std::cout << "B[150]=" << B[150] << " A[150]=" << A[150] << " q=" << q << std::endl;

}


/* ejer3b.cpp */
#include <omp.h>
#include <iostream>
#include <random>
#include <math.h>

const unsigned int N = 1000000;
double A[N][N], B[N][N], C[N][N], t[N];

int main(void){
  int nthreads, tnumber;

  std::random_device rd;  // Se utilizará para sembrar el generador de aleatorios
  std::mt19937 gen(rd()); // Sembrado de  mersenne_twister_engine con rd()
  std::uniform_real_distribution<> dis(0.0, 100.0); //Configuración del espacio de de generación

  for (int i = 0; i < N; ++i) {
    for (int j = 0; j < N; ++j){
      A[i][j] = dis(gen);
      B[i][j] = dis(gen);
      C[i][j] = dis(gen);
    }
  }

  for (int i = 0; i < N; ++i) {
    for (int j = 0; j < N; ++j){
      t[j] = A[i][j] + B[i][j];
      C[i][j] = t[j] + C[i][j];
    }
  }
  
 
  std::cout << "B[150][150]=" << B[150][150] << "C[150][150]=" << C[150][150] << "A[150][150]=" << A[150][150] << std::endl;

}

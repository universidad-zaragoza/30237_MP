/* histogram.cpp */
#include <omp.h>
#include <iostream>
#include <random>

const unsigned int DIM = 100000;
int A[DIM];
int histogram[10]={0,0,0,0,0,0,0,0,0,0};
int histogram2[10]={0,0,0,0,0,0,0,0,0,0};

int main(void){
  int l,i;
  int nthreads, tnumber;

  std::random_device rd;  // Se utilizará para sembrar el generador de aleatorios
  std::mt19937 gen(rd()); // Sembrado de  mersenne_twister_engine con rd()
  std::uniform_real_distribution<> dis(1,10); //Configuración del espacio de de generación

  for (int n = 0; n < DIM; ++n) {
    A[n] = dis(gen);
  }

  #pragma omp parallel for
  for(i=0; i<DIM; i++){
    //#pragma omp atomic
    histogram[A[i]]++;
  }

  for (i = 0; i < DIM; i++){
    histogram2[A[i]]++;
  }

  for (i = 0; i < 10; i++){
    std::cout << histogram[i] << " - " << histogram2[i];
    if (histogram[i] != histogram2[i]){
      std::cout << " ERROR";
    }
    std::cout << std::endl;
  }
}

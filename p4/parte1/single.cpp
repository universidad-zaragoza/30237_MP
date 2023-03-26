/* single.cpp */
#include <omp.h>
#include <iostream>

const unsigned int DIM = 12000000;
double A[DIM], B[DIM], C[DIM], D[DIM];

int main(void){
  int tnumber;
  double summed = 0.0;

  #pragma omp parallel sections shared(A,B,C,D) 
  {
    #pragma omp section
    {
      for (int i=0; i < DIM; i++){
        A[i] = 1.0;
      }
    }
    #pragma omp section
    {
      for (int i=0; i < DIM; i++){
        B[i] = 1.0;
      }
    }
    #pragma omp section
    {
      for (int i=0; i < DIM; i++){
        C[i] = 1.0;
      }
    }
    #pragma omp section
    {
      for (int i=0; i < DIM; i++){
        D[i] = 1.0;
      }
    }
  }

  #pragma omp parallel shared(summed) 
  {

    #pragma omp single 
    {
      for (int i=0; i < DIM; i++){
        summed = summed + A[i];
        summed = summed + B[i];
        summed = summed + C[i];
      }
      std::cout << "Resultado de la suma es: " << summed << std::endl;
    } //los threads esperan aqui


    #pragma omp for schedule(static, 4)
    for (int i = 0; i < DIM; i++){
      D[i] =  A[i] + B[i] * C[i];
    }
  }

  for (int i = 0; i < 12; i++){
    std::cout << "D[" << i << "]="<< std::fixed <<D[i] << std::endl;
  }
  
}

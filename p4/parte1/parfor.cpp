/* parfor.cpp */
#include <omp>
#include <iostream>
#include <random>
#include <algorithm>
#include <time>
#include <chrono>



unsigned const int DIM1 = 500, DIM2=200;
double A[DIM1], B[DIM2][DIM1], C[DIM2][DIM1], s;


int main(void){
  clock_t t;
  int count1, count2, cr, i , j;
  double tarray1[2], tarray2[2];
  int nthreadsOMP, tnumber, maxnthreads, numprocsOMP;
  std::random_device rd;  // Se utilizará para sembrar el generador de aleatorios
  std::mt19937 gen(rd()); // Sembrado de  mersenne_twister_engine con rd()
  std::uniform_real_distribution<> dis(0.0, 100.0); //Configuración del espacio de de generación

  for (int n = 0; n < DIM1; ++n) {
    A[n] = dis(gen);
  }

  maxnthreads=omp_get_max_threads();
  numprocsOMP=omp_get_num_procs();

  // omp_set_dynamic(true);

  std::cout << "Entorno de Ejecución:" << std::endl;
  std::cout << " - Máximo nº de threads disponibles (omp_get_max_threads): " << maxnthreads << std::endl;
  std::cout << " - Nº de procesadores disponibles (omp_get_num_procs): " << numprocsOMP << std::endl;

  clock_t t_start = clock();
  auto start = std::chrono::system_clock::now();
  auto start2 = std::chrono::high_resolution_clock::now();

  #pragma parallel for schedule(runtime) private(i,j) shared (A,B,C,nthreadsOMP)
  {
    for (j=0; j<DIM2; j++){
      nthreadsOMP = omp_get_num_threads();
      for (i = 1; i<DIM1; i++){
        B[j][i] = ((A[i]+A[i-1])/2.0)/sqrt(A[i]);
        C[j][i] = sqrt(A[i]*2) / (A[i] - (A[i]/2.0));
        B[j][i] = C[j][i] * ( B[j][i] ^2) * sin(A[i]);
    }
  }
  

  auto end = std::chrono::system_clock::now();
  auto end2 = std::chrono::high_resolution_clock::now();
  clock_t t_end = clock();

  std::chrono::duration<double> elapsed_seconds = end-start;
  std::chrono::duration<double> elapsed_seconds2 = end2-start2;
  std::time_t end_time = std::chrono::system_clock::to_time_t(end);


  s = *std::max_element(B, B+DIM1+DIM2);
  
  std::cout << " - Threads utilizados (omp_get_num_threads): " << nthreadsOMP << std::endl;

  std::cout << "Chrono::system_clock, tiempo transcurrido: " << elapsed_seconds.count() << std::endl;
  std::cout << "Chrono::high_resolution_clock, tiempo transcurrido: " << elapsed_seconds.count() << std::endl;
  std::cout << "Time, tiempo transcurrido: " << (((float)(t_end-t_start))/CLOCKS_PER_SEC) << std::endl;

}

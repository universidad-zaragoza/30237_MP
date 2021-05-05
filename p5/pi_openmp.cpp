#include <iostream>
#include <ctime>
#include <chrono>
#include <limits>
#include <iomanip>
#include <omp.h>

int main(int argc, char *argv[]){
  double nsubintervals = 100000000;
  double x, pi, area, subinterval;
  long int i;
  int count1, count2, cr;
  
  int maxnthreadsOMP = omp_get_max_threads();
  int nprocsOMP = omp_get_num_procs();
  
  if (argc == 2){
    nsubintervals = atof(argv[1]);
  }

  double wtr = omp_get_wtick();

  std::cout << "Nº de procesadores" << std::endl;
  std::cout << " - omp_get_num_procs: " << nprocsOMP << std::endl;
  std::cout << "Nº de threads" << std::endl;
  std::cout << " - omp_get_max_threads: " << maxnthreadsOMP << std::endl;
  std::cout << "Resolucion de relojes:" << std::endl;
  std::cout << " - system_clock: " << 1e6/cr << " usg-> " << cr/1e6 << " MHz" << std::endl;
  std::cout << " - omp_get_wtick: " << 1e6*wtr << " usg-> " << 1.0/(1e6*wtr) << " MHz" << std::endl;

  std::cout << "Calculando pi (nº intervalos " << nsubintervals << ")" << std::endl;

  std::clock_t t_start1 = std::clock();
  auto t_start2 = std::chrono::high_resolution_clock::now();
  double wtime1 = omp_get_wtime();

  for (i = 0; i < nsubintervals; i++){
    // threadID = omp_get_thread_num();
    // std::cout << "Thread " << threadID << " : iteración " << i << std::endl;
    x = (i-0.5)*subinterval;  // S1
    area = area + 4.0/(1.0 + x*x);   // S2
  }

  double wtime2 = omp_get_wtime();

  auto t_end2 = std::chrono::high_resolution_clock::now();
  std::clock_t t_end1 = std::clock();
  std::chrono::duration<double> elapsed_seconds2 = t_end2-t_start2;

  std::cout << "***************************************" << std::endl;
  std::cout << " PIcalculado =" << pi << std::endl;
  std::cout << " PIreal = 3.1415926535897932385" << std::endl;
  std::cout << std::endl;
  std::cout << "*** tiempos ***" << std::endl;
  std::cout << "CPU clock = " << (((float)(t_end1-t_start1))/CLOCKS_PER_SEC) << std::endl;
  std::cout << "Wall Clock = " << elapsed_seconds2.count() << std::endl;
  std::cout << "OMP time = " << wtime2 - wtime1 << " sg" << std::endl;
  std::cout << "-----------------------------------------" << std::endl;
 
}

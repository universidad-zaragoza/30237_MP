#include <iostream>
#include <ctime>
#include <chrono>
#include <limits>
#include <iomanip>
#include <omp.h>

int main(int argc, char **argv){
  int64_t nsubintervals = 100000000000;
  double x, pi, area, subinterval;
  long int i;
  int count1, count2, cr;
  char * pfin;

  if (argc != 2 ){
    std::cout << "USO: comando tamano_subintervalo" << std::endl;
    exit(0);
  }
  nsubintervals = strtoull(argv[1],&pfin, 10);

  std::cout << "Nº de procesadores: " << omp_get_num_procs() << std::endl;
  std::cout << "Nª de threads: " << omp_get_num_threads() << std::endl;
  std::cout << "Resolución de los relojes:" << std::endl;
  std::cout << " - system_clock(std::clock): " << 1e6/CLOCKS_PER_SEC << " us -- " << CLOCKS_PER_SEC/1e6 << " MHz" << std::endl;

  std::clock_t t_start1 = std::clock();
  auto t_start2 = std::chrono::high_resolution_clock::now();

  subinterval = 1.0 / (double) nsubintervals;
  area = 0.0;
 
  for (i = 0; i < nsubintervals; i++){
	  x = (i-0.5)*subinterval; 				//S1 
	  area = area + (4.0/(1.0 + x*x));	 	//S2
  }

  pi = subinterval*area;

  auto t_end2 = std::chrono::high_resolution_clock::now();
  std::clock_t t_end1 = std::clock();
  std::chrono::duration<double> elapsed_seconds2 = t_end2-t_start2;

  std::cout << "***************************************" << std::endl;
  std::cout << " PIcalculado =" << std::setprecision(18) << pi << std::endl;
  std::cout << " PIreal = 3.1415926535897932385" << std::endl;
  std::cout << std::endl;
  std::cout << "*** tiempos ***" << std::endl;
  std::cout << "CPU clock = " << (((float)(t_end1-t_start1))/CLOCKS_PER_SEC) << " sg" << std::endl;
  std::cout << "Wall Clock = " << elapsed_seconds2.count() << " sg" << std::endl;
  std::cout << "-----------------------------------------" << std::endl;

}

#include <iostream>
#include <omp.h>

void trabajo(int id) {

   std::cout << "Inicio tarea " << id << " en thread " << omp_get_thread_num() << std::endl;
        
   // Simular trabajo
   for (volatile int i = 0; i < 100000000; i++);
   
   std::cout << "Fin tarea " << id << " en thread " << omp_get_thread_num() << std::endl;
}
 
int main() {
    #pragma omp parallel
    {
        #pragma omp single   // ???
        {
        std::cout << "Creando tareas...\n";

        #pragma omp task
        trabajo(1);

        #pragma omp task
        trabajo(2);

        #pragma omp task
        trabajo(3);

        #pragma omp taskwait

        std::cout << "Todas las tareas han finalizado\n";
        }
    }
    return 0;
}

#include <iostream>
#include <omp.h>
int main()
{
    #pragma omp parallel
    {
        std::cout << "Hello " << omp_get_thread_num() << " ";
        std::cout << "World " << omp_get_thread_num() << std::endl;
    }
    return 0;
}

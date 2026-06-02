//C√digo para mostrar como se reparten los identificadores de bloques e hilos para cada thread creado as√≠ como el total de hilos
#include <stdio.h>

__global__ void hello() {
    printf("Hola desde la GPU! bloque %d thread %d\n", blockIdx.x, threadIdx.x);
}

int main() {
    hello<<<3, 5>>>();
    cudaDeviceSynchronize();
    return 0;
}

//C�digo para mostrar como se reparten los identificadores de bloques e hilos para cada thread creado así como el total de hilos
#include <stdio.h>

__global__ void hello() {
    //Pregunta: ¿que significan los siguiente 4 valores
    printf("Hola desde la GPU! bloque %d thread %d gridDim %d blockDim %d\n", blockIdx.x, threadIdx.x, gridDim.x, blockDim.x);
}

int main() {
    hello<<<3, 5>>>();
    cudaDeviceSynchronize();
    return 0;
}

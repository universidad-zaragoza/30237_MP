#include <stdio.h>

__global__ void vecAdd(float *a, float *b, float *c, int n) {
    int i = blockIdx.x * blockDim.x + threadIdx.x;

    // PREGUNTA!!!: ¿por qué motivo es necesario esta clausula if?
    if (i < n)
        c[i] = a[i] + b[i];
}

int main() {
    int n = 1 << 20; // ~1 million elements
    size_t size = n * sizeof(float);

    float *h_a = (float*)malloc(size);
    float *h_b = (float*)malloc(size);
    float *h_c = (float*)malloc(size);

    for (int i = 0; i < n; i++) {
        h_a[i] = i * 1.0f;
        h_b[i] = 2.0f * i;
    }

    float *d_a, *d_b, *d_c;

    cudaMalloc(&d_a, size);
    cudaMalloc(&d_b, size);
    cudaMalloc(&d_c, size);

    cudaMemcpy(d_a, h_a, size, cudaMemcpyHostToDevice);
    cudaMemcpy(d_b, h_b, size, cudaMemcpyHostToDevice);

    int threads = 256;
    int blocks = (n + threads - 1) / threads;

    vecAdd<<<blocks, threads>>>(d_a, d_b, d_c, n);

    cudaDeviceSynchronize();

    cudaMemcpy(h_c, d_c, size, cudaMemcpyDeviceToHost);

    printf("c[0]=%f c[n-1]=%f\n", h_c[0], h_c[n-1]);

    cudaFree(d_a);
    cudaFree(d_b);
    cudaFree(d_c);

    free(h_a);
    free(h_b);
    free(h_c);
}

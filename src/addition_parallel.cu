#include <stdio.h>
#include <iostream>
#include <time.h>	// for the seed of the random number generator
__global__ void add(int *a, int *b, int *c){
	c[blockIdx.x] = a[blockIdx.x] + b[blockIdx.x];
}

// CPU function to generate a vector of random integers
// Source:
// https://docs.it4i.cz/anselm-cluster-documentation/software/nvidia-cuda
void random_ints (int *a, int n) {
	srand(time(NULL)); // Set a random seed (unique if execured once per second)
	for (int i = 0; i < n; i++)
	a[i] = rand() % 10000; // random number between 0 and 9999
}

#define N 512

int main(void){
	int *a, *b, *c;
	int *d_a, *d_b, *d_c;
	int size = N * sizeof(int);

	cudaMalloc((void **)&d_a, size);
	cudaMalloc((void **)&d_b, size);
	cudaMalloc((void **)&d_c, size);

	a = (int *)malloc(size); random_ints(a,N);
	b = (int *)malloc(size); random_ints(b,N);
	c = (int *)malloc(size);

	cudaMemcpy(d_a, a, size, cudaMemcpyHostToDevice);
	cudaMemcpy(d_b, b, size, cudaMemcpyHostToDevice);

	add<<<N,1>>>(d_a, d_b, d_c);

	cudaMemcpy(c, d_c, size, cudaMemcpyDeviceToHost);

	std::cerr << "c[0]: " << c[0] << std::endl;
	std::cerr << "c[1]: " << c[1] << std::endl;

	free(a); free(b); free(c);
	cudaFree(d_a); cudaFree(d_b); cudaFree(d_c);
	return 0;
}

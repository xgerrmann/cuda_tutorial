// Tutorial from Nvidia:
// https://www.nvidia.com/docs/IO/116711/sc11-cuda-c-basics.pdf
// Works with CUDA 7.5

#include <stdio.h>
#include <iostream>


__global__ void add(int *a, int *b, int *c){
	*c = *a + *b;
}


int main(void){
	int a, b, c;
	int *d_a, *d_b, *d_c;
	int size = sizeof(int);

	cudaMalloc((void**)&d_a, size);
	cudaMalloc((void**)&d_b, size);
	cudaMalloc((void**)&d_c, size);

	a = 2;
	b = 7;

	cudaMemcpy(d_a, &a, size, cudaMemcpyHostToDevice);
	cudaMemcpy(d_b, &b, size, cudaMemcpyHostToDevice);

	add<<<1,1>>>(d_a, d_b, d_c);

	cudaMemcpy(&c, d_c, size, cudaMemcpyDeviceToHost);

	cudaFree(d_a); cudaFree(d_b); cudaFree(d_c);

	std::cerr << "2 + 7 = " << c << std::endl;

	return 0;
}

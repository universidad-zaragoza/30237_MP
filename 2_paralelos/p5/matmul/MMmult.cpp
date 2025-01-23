/*
 
 Copyright (c) 2009 University of Illinois at Urbana-Champaign.  All rights reserved.
 
 
 University of Illinois at Urbana-Champaign
 
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
 
 CONTRIBUTORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 
 FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
 
 WITH THE SOFTWARE.
 */



// Several versions of parallel codes for matrix-matrix multiplication using OpenMP

#include <stdio.h>   
#include <stdlib.h> 
#include <omp.h>
#include "2DArray.h"

#define MIN(X, Y) ((X) < (Y) ? (X) : (Y)) 

// define sizes of matrices to be used
#define M 1000
#define N 1000
#define P 1000

#define GRAIN   32768 /* product size below which matmultleaf is used */  

void seqMatMult(int m, int n, int p, float **A, float **B, float **C)   
{   
	int i, j, k;   
	for (i = 0; i < m; i++)   
		for (j = 0; j < n; j++){          
			C[i][j]=0;   
			for (k = 0; k < p; k++)   
				C[i][j] += A[i][k]*B[k][j];   
		}   
}  





  
void matmultleaf(int m, int n, int p, int mf, int ml, int nf, int nl, int pf, int pl, float **A, float **B, float **C)    
/*  
  subroutine that uses the simple triple loop to multiply  
  a submatrix from A with a submatrix from B and store the  
  result in a submatrix of C.   
  (We could use a tiled version,for better performance)  
*/  
// mf, ml; /* first and last+1 i index */  
// nf, nl; /* first and last+1 j index */  
// pf, pl; /* first and last+1 k index */  
{   


	//printf ("leaf mf %d ml %d nf %d nl %d pf %d pl %d\n", mf,ml,nf,nl,pf,pl);
	for (int i = mf; i < ml; i++)   
		for (int j = nf; j < nl; j++)   
			for (int k = pf; k < pl; k++)   
				C[i][j] += A[i][k]*B[k][j];   
}   


void seqmatmultrec(int m, int n, int p, int mf, int ml, int nf, int nl, int pf, int pl, float **A, float **B, float **C)
/*    
 recursive subroutine to compute the product of two  
 submatrices of A and B and store the result in C  
 */  
// mf, ml; /* first and last+1 i index */  
// nf, nl; /* first and last+1 j index */  
// pf, pl; /* first and last+1 k index */  


{     
	if ((ml-mf)*(nl-nf)*(pl-pf) < GRAIN)   
		matmultleaf(m, n, p, mf, ml, nf, nl, pf, pl, A, B, C);   
	else {  // is there a better grouping of tasks?
		
		seqmatmultrec(m, n, p, mf, mf+(ml-mf)/2, nf, nf+(nl-nf)/2, pf, pf+(pl-pf)/2, A, B, C); 
		seqmatmultrec(m, n, p, mf+(ml-mf)/2, ml, nf, nf+(nl-nf)/2, pf, pf+(pl-pf)/2, A, B, C);   
		seqmatmultrec(m, n, p, mf, mf+(ml-mf)/2, nf, nf+(nl-nf)/2, pf+(pl-pf)/2, pl, A, B, C);   
		seqmatmultrec(m, n, p, mf+(ml-mf)/2, ml, nf+(nl-nf)/2, nl, pf+(pl-pf)/2, pl, A, B, C);  
		seqmatmultrec(m, n, p, mf, mf+(ml-mf)/2, nf+(nl-nf)/2, nl, pf, pf+(pl-pf)/2, A, B, C);   
		seqmatmultrec(m, n, p, mf, mf+(ml-mf)/2, nf+(nl-nf)/2, nl, pf+(pl-pf)/2, pl, A, B, C);   
		seqmatmultrec(m, n, p, mf+(ml-mf)/2, ml, nf, nf+(nl-nf)/2, pf+(pl-pf)/2, pl, A, B, C);   
		seqmatmultrec(m, n, p, mf+(ml-mf)/2, ml, nf+(nl-nf)/2, nl, pf, pf+(pl-pf)/2, A, B, C);   
		
		
	}}




/*   
 Recursive code for matrix multiplication.   
 The recursion uses the formula  
 C00 = A00*B00 + A01*B10  
 C01 = A00*B01 + B01*B11  
 C10 = A10*B00 + A11*B10  
 C11 = A10*B01 + A11*B11  
 */  

void matmultrec(int m, int n, int p, int mf, int ml, int nf, int nl, int pf, int pl, float **A, float **B, float **C)
/*    
  recursive subroutine to compute the product of two  
  submatrices of A and B and store the result in C  
*/  
// mf, ml; /* first and last+1 i index */  
// nf, nl; /* first and last+1 j index */  
// pf, pl; /* first and last+1 k index */  
{  
if ((ml-mf)*(nl-nf)*(pl-pf) < GRAIN)   
     matmultleaf(m, n, p, mf, ml, nf, nl, pf, pl, A, B, C);   
else {  // is there a better grouping of tasks?
	
	seqmatmultrec(m, n, p, mf, mf+(ml-mf)/2, nf, nf+(nl-nf)/2, pf, pf+(pl-pf)/2, A, B, C); 
	seqmatmultrec(m, n, p, mf+(ml-mf)/2, ml, nf, nf+(nl-nf)/2, pf, pf+(pl-pf)/2, A, B, C);   
	seqmatmultrec(m, n, p, mf, mf+(ml-mf)/2, nf, nf+(nl-nf)/2, pf+(pl-pf)/2, pl, A, B, C);   
	seqmatmultrec(m, n, p, mf+(ml-mf)/2, ml, nf+(nl-nf)/2, nl, pf+(pl-pf)/2, pl, A, B, C);  
	seqmatmultrec(m, n, p, mf, mf+(ml-mf)/2, nf+(nl-nf)/2, nl, pf, pf+(pl-pf)/2, A, B, C);   
	seqmatmultrec(m, n, p, mf, mf+(ml-mf)/2, nf+(nl-nf)/2, nl, pf+(pl-pf)/2, pl, A, B, C);   
	seqmatmultrec(m, n, p, mf+(ml-mf)/2, ml, nf, nf+(nl-nf)/2, pf+(pl-pf)/2, pl, A, B, C);   
	seqmatmultrec(m, n, p, mf+(ml-mf)/2, ml, nf+(nl-nf)/2, nl, pf, pf+(pl-pf)/2, A, B, C);   
	



   }   
}


              


int CheckResults(int m, int n, float **C, float **C1)
{
#define THRESHOLD 0.1
//
//  May need to take into consideration the floating point roundoff error
//    due to parallel execution
//
	for (int i = 0; i < m; i++) {
		for (int j = 0; j < n; j++) {
			if ((C[i][j] - C1[i][j]) > THRESHOLD ) {
				printf("Error %f  %f, i %d j %d", C[i][j], C1[i][j], i, j);
				return 1;
			}
		}
	}
	return 0;
}
  
int main(int argc, char* argv[])   
{      
	float  **A = Allocate2DArray< float >(M, P);
	float  **B = Allocate2DArray< float >(P, N);

	float **C0  = Allocate2DArray< float >(M, N);
	float **C1  = Allocate2DArray< float >(M, N);
	float **C2 = Allocate2DArray< float >(M, N);
	

	int i, j; 
	double start, end;

	for (i = 0; i < M; i++) {   
		for (j = 0; j < P; j++) {   
			A[i][j] = (double)(rand()%100) / 10.0;   
		}      
	}   

	for (i = 0; i < P; i++) {   
		for (j = 0; j < N; j++) {   
			B[i][j] = (double)(rand()%100) / 10.0;   
		}      
	}   

	printf("Execute Sequential iterative matmult (M= %d N= %d P= %d)\n", M, N, P);
	start = omp_get_wtime();
	seqMatMult(M, N, P, A, B, C0);
	end = omp_get_wtime();
	printf("Time = %f seconds\n\n",end-start);

    printf("Execute Sequential recursive matmult (M= %d N= %d P= %d)\n", M, N, P);
	start = omp_get_wtime();
	seqmatmultrec(M, N, P, 0,M,0,N,0,P,A, B, C1);
	end = omp_get_wtime();
	if (CheckResults(M, N, C0, C1)) 
		printf("Error in matmultr\n\n");
	else
		printf("OKAY\nTime = %f seconds\n\n",end-start);
	
	
	printf("Execute parallel recursive matmult (M= %d N= %d P= %d)\n", M, N, P);
	start = omp_get_wtime();
	matmultrec(M, N, P, 0,M,0,N,0,P,A, B, C2);
	end = omp_get_wtime();

	if (CheckResults(M, N, C0, C2)) 
		printf("Error in matmultr\n\n");
	else
		printf("OKAY\nTime = %f seconds\n\n",end-start);

  return 0;   
}  

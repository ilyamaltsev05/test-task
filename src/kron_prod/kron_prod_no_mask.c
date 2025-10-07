#include <GraphBLAS.h>

extern GrB_Info init_A(GrB_Matrix*);
extern GrB_Info init_B(GrB_Matrix*);
extern GrB_Info init_C(GrB_Matrix*);
extern GrB_Info init_M(GrB_Matrix*);


GrB_Info kron_prod_no_mask(GrB_Matrix *A, GrB_Matrix *B, GrB_Matrix *C) {
	GrB_Info status_code = GrB_kronecker(*C, GrB_NULL, GrB_NULL, GrB_LAND, *A, *B, GrB_NULL);
	return status_code;
}


int main() {
	GrB_Info init_status = GrB_init(1);
	if (init_status) {
		fprintf(stderr, "%d\n", init_status);
		return 1;
	}

	GrB_Matrix A;
	GrB_Matrix B;
	GrB_Matrix C;

	GrB_Info status_code = init_A(&A);
	if (status_code) {
		fprintf(stderr, "%d\n", status_code);
		return 1;
	}

	status_code = init_B(&B);
	if (status_code) {
		fprintf(stderr, "%d\n", status_code);
		return 1;
	}

	status_code = init_C(&C);
	if (status_code) {
		fprintf(stderr, "%d\n", status_code);
		return 1;
	}

	status_code = kron_prod_no_mask(&A, &B, &C);
	if (status_code) {
		fprintf(stderr, "%d\n", status_code);
		return 1;
	}

	GxB_Matrix_fprint(C, "matrix C=kron_prod(A, B)", GxB_COMPLETE, stdout);

	return GrB_finalize();
}

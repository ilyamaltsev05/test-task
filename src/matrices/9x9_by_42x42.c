#include <GraphBLAS.h>

#define A_SIZE 9
#define B_SIZE 42

extern GrB_Info import_matrix(char*, GrB_Matrix*);

GrB_Info init_A(GrB_Matrix *A) {
	return import_matrix("./src/matrices/sms_examples/9x9_matrix.sms", A);
}


GrB_Info init_B(GrB_Matrix *B) {
	return import_matrix("./src/matrices/sms_examples/42x42_matrix.sms", B);
}


GrB_Info init_C(GrB_Matrix *C) {
	return GrB_Matrix_new(C, GrB_BOOL, A_SIZE * B_SIZE, A_SIZE * B_SIZE);
}


GrB_Info init_M(GrB_Matrix *M) {
	GrB_Info status_code = GrB_Matrix_new(M, GrB_BOOL, A_SIZE * B_SIZE, A_SIZE * B_SIZE);
	if (status_code) {
		return status_code;
	}
	for (int i = 0; i < A_SIZE * B_SIZE; i++) {
		status_code = GrB_Matrix_setElement(*M, true, i, i);
		if (status_code) {
			return status_code;
		}
	}

	return 0;
}

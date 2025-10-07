#include <GraphBLAS.h>
#include <stdio.h>


GrB_Info init_A(GrB_Matrix *A) {
    GrB_Info status_code = GrB_Matrix_new(A, GrB_BOOL, 2, 2);
    if (status_code) {
        return status_code;
    }

    /* set A as 
    1 1
    1 1
    */

    status_code = GrB_Matrix_setElement(*A, true, 0, 0);
    if (status_code) {
        return status_code;
    }

    status_code = GrB_Matrix_setElement(*A, true, 0, 1);
    if (status_code) {
        return status_code;
    }

    status_code = GrB_Matrix_setElement(*A, true, 1, 0);
    if (status_code) {
        return status_code;
    }

    status_code = GrB_Matrix_setElement(*A, true, 1, 1);
    if (status_code) {
        return status_code;
    }

    GxB_Matrix_fprint(*A, "matrix A", GxB_COMPLETE, stdout);

    return 0;
}


GrB_Info init_B(GrB_Matrix *B) {
    GrB_Info status_code = GrB_Matrix_new(B, GrB_BOOL, 2, 2);
    if (status_code) {
        return status_code;
    }

    /* set B as 
    0 1
    1 0
    */

    status_code = GrB_Matrix_setElement(*B, true, 1, 0);
    if (status_code) {
        return status_code;
    }

    status_code = GrB_Matrix_setElement(*B, true, 0, 1);
    if (status_code) {
        return status_code;
    }

    GxB_Matrix_fprint(*B, "matrix A", GxB_COMPLETE, stdout);

    return 0;
}


GrB_Info init_C(GrB_Matrix *C) {
    return GrB_Matrix_new(C, GrB_BOOL, 4, 4);
}


GrB_Info init_M(GrB_Matrix *M) {
    GrB_Info status_code = GrB_Matrix_new(M, GrB_BOOL, 4, 4);
	if (status_code) {
		return status_code;
	}
	for (int i = 0; i < 4; i++) {
		status_code = GrB_Matrix_setElement(*M, true, i, i);
		if (status_code) {
			return status_code;
		}
	}

	GxB_Matrix_fprint(*M, "matrix mask M", GxB_COMPLETE, stdout);

	return 0;
}

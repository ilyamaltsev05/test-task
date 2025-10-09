#include <stdio.h>
#include <GraphBLAS.h>

GrB_Info import_matrix(char *path, GrB_Matrix *matrix) {
    FILE* file = fopen(path, "r");
    if (file == NULL) {
        fprintf(stderr, "%s", "Can't open file ");
        fprintf(stderr, "%s\n", path);
        return 1;
    }

    GrB_Index rows;
    GrB_Index cols;
    char some;
    fscanf(file, "%" PRIu64 " %" PRIu64 " %c" "\n", &rows, &cols, &some);

    GrB_Info status_code = GrB_Matrix_new(matrix, GrB_BOOL, rows, cols);
    if (status_code) {
        return status_code;
    }

    GrB_Index i;
    GrB_Index j;
    GrB_Index entry;
    while (fscanf(file, "%"PRIu64  " %"PRIu64 " %"PRIu64 "\n", &i, &j, &entry) == 3) {
        if (i == 0 && j == 0) {
            break;
        }
        status_code = GrB_Matrix_setElement(*matrix, true, i - 1, j - 1);
        if (status_code) {
            return status_code;
        }
    }

    return 0;
}

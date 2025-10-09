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

    GrB_Matrix_new(matrix, GrB_BOOL, rows, cols);

    GrB_Index i;
    GrB_Index j;
    GrB_Index entry;
    while (fscanf(file, "%"PRIu64  " %"PRIu64 " %"PRIu64 "\n", &i, &j, &entry) == 3) {
        GrB_Matrix_setElement(*matrix, true, i, j);
    }

    return 0;
}

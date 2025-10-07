COMPILER = gcc
BUILD_DIR = build
SOURCE_DIR = src
RM = rm

examples: make_directories kronecker_product matrices

lint:
	clang-tidy --config-file=.clang-tidy ./$(SOURCE_DIR)/kron_prod/*.c
	clang-tidy --config-file=.clang-tidy ./$(SOURCE_DIR)/matrices/*.c

make_directories:
	mkdir -p ./$(BUILD_DIR)
	mkdir -p ./$(BUILD_DIR)/examples

kronecker_product: ./$(BUILD_DIR)/kron_prod_no_mask.o ./$(BUILD_DIR)/kron_prod_with_mask.o

matrices: simple_2x2 empty_diag_2x2

simple_2x2: ./$(BUILD_DIR)/examples/simple_2x2_no_mask.out ./$(BUILD_DIR)/examples/simple_2x2_with_mask.out

empty_diag_2x2: ./$(BUILD_DIR)/examples/2x2_empty_diag_B_no_mask.out ./$(BUILD_DIR)/examples/2x2_empty_diag_B_with_mask.out

./$(BUILD_DIR)/examples/simple_2x2_no_mask.out: ./$(SOURCE_DIR)/matrices/simple_2x2_matrices.c ./$(BUILD_DIR)/kron_prod_no_mask.o
	$(COMPILER) ./$(SOURCE_DIR)/matrices/simple_2x2_matrices.c ./$(BUILD_DIR)/kron_prod_no_mask.o \
	-o ./$(BUILD_DIR)/examples/simple_2x2_no_mask.out -I/usr/local/include/suitesparse -l:libgraphblas.so.10

./$(BUILD_DIR)/examples/simple_2x2_with_mask.out: ./$(SOURCE_DIR)/matrices/simple_2x2_matrices.c ./$(BUILD_DIR)/kron_prod_with_mask.o
	$(COMPILER) ./$(SOURCE_DIR)/matrices/simple_2x2_matrices.c ./$(BUILD_DIR)/kron_prod_with_mask.o \
	-o ./$(BUILD_DIR)/examples/simple_2x2_with_mask.out -I/usr/local/include/suitesparse -l:libgraphblas.so.10

./$(BUILD_DIR)/kron_prod_no_mask.o: ./$(SOURCE_DIR)/kron_prod/kron_prod_no_mask.c
	$(COMPILER) -c ./$(SOURCE_DIR)/kron_prod/kron_prod_no_mask.c -o ./$(BUILD_DIR)/kron_prod_no_mask.o \
	-I/usr/local/include/suitesparse -l:libgraphblas.so.10

./$(BUILD_DIR)/kron_prod_with_mask.o: ./$(SOURCE_DIR)/kron_prod/kron_prod_with_mask.c
	$(COMPILER) -c ./$(SOURCE_DIR)/kron_prod/kron_prod_with_mask.c -o ./$(BUILD_DIR)/kron_prod_with_mask.o \
	-I/usr/local/include/suitesparse -l:libgraphblas.so.10

./$(BUILD_DIR)/examples/2x2_empty_diag_B_no_mask.out: ./$(SOURCE_DIR)/matrices/2x2_empty_diag_B.c ./$(BUILD_DIR)/kron_prod_no_mask.o
	$(COMPILER) ./$(SOURCE_DIR)/matrices/2x2_empty_diag_B.c ./$(BUILD_DIR)/kron_prod_no_mask.o \
	-o ./$(BUILD_DIR)/examples/2x2_empty_diag_B_no_mask.out -I/usr/local/include/suitesparse -l:libgraphblas.so.10

./$(BUILD_DIR)/examples/2x2_empty_diag_B_with_mask.out: ./$(SOURCE_DIR)/matrices/2x2_empty_diag_B.c ./$(BUILD_DIR)/kron_prod_no_mask.o
	$(COMPILER) ./$(SOURCE_DIR)/matrices/2x2_empty_diag_B.c ./$(BUILD_DIR)/kron_prod_with_mask.o \
	-o ./$(BUILD_DIR)/examples/2x2_empty_diag_B_with_mask.out -I/usr/local/include/suitesparse -l:libgraphblas.so.10

clean:
	$(RM) ./$(BUILD_DIR)/examples/*.out
	$(RM) ./$(BUILD_DIR)/*.o

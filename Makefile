COMPILER = gcc
BUILD_DIR = build
SOURCE_DIR = src
RM = rm

examples: make_directories kronecker_product matrices perfomance

perfomance: make_directories perf_kron_prod perf_matrices

perf_matrices: 9x9_by_42x42 200x200_by_150x150

200x200_by_150x150: ./$(BUILD_DIR)/examples/200x200_by_150x150_no_mask.out ./$(BUILD_DIR)/examples/200x200_by_150x150_with_mask.out

./$(BUILD_DIR)/examples/200x200_by_150x150_no_mask.out: ./$(SOURCE_DIR)/importer.c ./$(SOURCE_DIR)/matrices/200x200_by_150x150.c
	$(COMPILER) ./$(SOURCE_DIR)/importer.c ./$(SOURCE_DIR)/matrices/200x200_by_150x150.c ./$(BUILD_DIR)/perf_kron_prod_no_mask.o  \
	-o ./$(BUILD_DIR)/examples/200x200_by_150x150_no_mask.out -I/usr/local/include/suitesparse -lgraphblas

./$(BUILD_DIR)/examples/200x200_by_150x150_with_mask.out: ./$(SOURCE_DIR)/importer.c ./$(SOURCE_DIR)/matrices/200x200_by_150x150.c
	$(COMPILER) ./$(SOURCE_DIR)/importer.c ./$(SOURCE_DIR)/matrices/200x200_by_150x150.c ./$(BUILD_DIR)/perf_kron_prod_with_mask.o  \
	-o ./$(BUILD_DIR)/examples/200x200_by_150x150_with_mask.out -I/usr/local/include/suitesparse -lgraphblas

9x9_by_42x42: ./$(BUILD_DIR)/examples/9x9_by_42x42_no_mask.out ./$(BUILD_DIR)/examples/9x9_by_42x42_with_mask.out

./$(BUILD_DIR)/examples/9x9_by_42x42_no_mask.out: ./$(SOURCE_DIR)/importer.c ./$(SOURCE_DIR)/matrices/9x9_by_42x42.c
	$(COMPILER) ./$(SOURCE_DIR)/importer.c ./$(SOURCE_DIR)/matrices/9x9_by_42x42.c ./$(BUILD_DIR)/perf_kron_prod_no_mask.o  \
	-o ./$(BUILD_DIR)/examples/9x9_by_42x42_no_mask.out -I/usr/local/include/suitesparse -lgraphblas

./$(BUILD_DIR)/examples/9x9_by_42x42_with_mask.out: ./$(SOURCE_DIR)/importer.c ./$(SOURCE_DIR)/matrices/9x9_by_42x42.c
	$(COMPILER) ./$(SOURCE_DIR)/importer.c ./$(SOURCE_DIR)/matrices/9x9_by_42x42.c ./$(BUILD_DIR)/perf_kron_prod_with_mask.o  \
	-o ./$(BUILD_DIR)/examples/9x9_by_42x42_with_mask.out -I/usr/local/include/suitesparse -lgraphblas

perf_kron_prod: ./$(BUILD_DIR)/perf_kron_prod_no_mask.o ./$(BUILD_DIR)/perf_kron_prod_with_mask.o

./$(BUILD_DIR)/perf_kron_prod_no_mask.o: ./$(SOURCE_DIR)/kron_prod/perf_kron_prod_no_mask.c
	$(COMPILER) -c ./$(SOURCE_DIR)/kron_prod/perf_kron_prod_no_mask.c -o ./$(BUILD_DIR)/perf_kron_prod_no_mask.o \
	-I/usr/local/include/suitesparse -lgraphblas

./$(BUILD_DIR)/perf_kron_prod_with_mask.o: ./$(SOURCE_DIR)/kron_prod/perf_kron_prod_with_mask.c
	$(COMPILER) -c ./$(SOURCE_DIR)/kron_prod/perf_kron_prod_with_mask.c -o ./$(BUILD_DIR)/perf_kron_prod_with_mask.o \
	-I/usr/local/include/suitesparse -lgraphblas

run_examples: examples
	./$(BUILD_DIR)/examples/simple_2x2_no_mask.out
	./$(BUILD_DIR)/examples/simple_2x2_with_mask.out
	./$(BUILD_DIR)/examples/2x2_empty_diag_B_no_mask.out
	./$(BUILD_DIR)/examples/2x2_empty_diag_B_with_mask.out
	./$(BUILD_DIR)/examples/2x2_by_3x3_no_mask.out
	./$(BUILD_DIR)/examples/2x2_by_3x3_with_mask.out

lint:
	clang-tidy --config-file=.clang-tidy ./$(SOURCE_DIR)/kron_prod/*.c
	clang-tidy --config-file=.clang-tidy ./$(SOURCE_DIR)/matrices/*.c

make_directories:
	mkdir -p ./$(BUILD_DIR)
	mkdir -p ./$(BUILD_DIR)/examples

kronecker_product: ./$(BUILD_DIR)/kron_prod_no_mask.o ./$(BUILD_DIR)/kron_prod_with_mask.o

matrices: simple_2x2 empty_diag_2x2 2x2_by_3x3

simple_2x2: ./$(BUILD_DIR)/examples/simple_2x2_no_mask.out ./$(BUILD_DIR)/examples/simple_2x2_with_mask.out

empty_diag_2x2: ./$(BUILD_DIR)/examples/2x2_empty_diag_B_no_mask.out ./$(BUILD_DIR)/examples/2x2_empty_diag_B_with_mask.out

2x2_by_3x3: ./$(BUILD_DIR)/examples/2x2_by_3x3_no_mask.out ./$(BUILD_DIR)/examples/2x2_by_3x3_with_mask.out

./$(BUILD_DIR)/examples/2x2_by_3x3_no_mask.out: ./$(SOURCE_DIR)/matrices/2x2_by_3x3.c ./$(BUILD_DIR)/kron_prod_no_mask.o
	$(COMPILER) ./$(SOURCE_DIR)/matrices/2x2_by_3x3.c ./$(BUILD_DIR)/kron_prod_no_mask.o \
	-o ./$(BUILD_DIR)/examples/2x2_by_3x3_no_mask.out -I/usr/local/include/suitesparse -lgraphblas

./$(BUILD_DIR)/examples/2x2_by_3x3_with_mask.out: ./$(SOURCE_DIR)/matrices/2x2_by_3x3.c ./$(BUILD_DIR)/kron_prod_with_mask.o
	$(COMPILER) ./$(SOURCE_DIR)/matrices/2x2_by_3x3.c ./$(BUILD_DIR)/kron_prod_with_mask.o \
	-o ./$(BUILD_DIR)/examples/2x2_by_3x3_with_mask.out -I/usr/local/include/suitesparse -lgraphblas

./$(BUILD_DIR)/examples/simple_2x2_no_mask.out: ./$(SOURCE_DIR)/matrices/simple_2x2_matrices.c ./$(BUILD_DIR)/kron_prod_no_mask.o
	$(COMPILER) ./$(SOURCE_DIR)/matrices/simple_2x2_matrices.c ./$(BUILD_DIR)/kron_prod_no_mask.o \
	-o ./$(BUILD_DIR)/examples/simple_2x2_no_mask.out -I/usr/local/include/suitesparse -lgraphblas

./$(BUILD_DIR)/examples/simple_2x2_with_mask.out: ./$(SOURCE_DIR)/matrices/simple_2x2_matrices.c ./$(BUILD_DIR)/kron_prod_with_mask.o
	$(COMPILER) ./$(SOURCE_DIR)/matrices/simple_2x2_matrices.c ./$(BUILD_DIR)/kron_prod_with_mask.o \
	-o ./$(BUILD_DIR)/examples/simple_2x2_with_mask.out -I/usr/local/include/suitesparse -lgraphblas

./$(BUILD_DIR)/kron_prod_no_mask.o: ./$(SOURCE_DIR)/kron_prod/kron_prod_no_mask.c
	$(COMPILER) -c ./$(SOURCE_DIR)/kron_prod/kron_prod_no_mask.c -o ./$(BUILD_DIR)/kron_prod_no_mask.o \
	-I/usr/local/include/suitesparse -lgraphblas

./$(BUILD_DIR)/kron_prod_with_mask.o: ./$(SOURCE_DIR)/kron_prod/kron_prod_with_mask.c
	$(COMPILER) -c ./$(SOURCE_DIR)/kron_prod/kron_prod_with_mask.c -o ./$(BUILD_DIR)/kron_prod_with_mask.o \
	-I/usr/local/include/suitesparse -lgraphblas

./$(BUILD_DIR)/examples/2x2_empty_diag_B_no_mask.out: ./$(SOURCE_DIR)/matrices/2x2_empty_diag_B.c ./$(BUILD_DIR)/kron_prod_no_mask.o
	$(COMPILER) ./$(SOURCE_DIR)/matrices/2x2_empty_diag_B.c ./$(BUILD_DIR)/kron_prod_no_mask.o \
	-o ./$(BUILD_DIR)/examples/2x2_empty_diag_B_no_mask.out -I/usr/local/include/suitesparse -lgraphblas

./$(BUILD_DIR)/examples/2x2_empty_diag_B_with_mask.out: ./$(SOURCE_DIR)/matrices/2x2_empty_diag_B.c ./$(BUILD_DIR)/kron_prod_no_mask.o
	$(COMPILER) ./$(SOURCE_DIR)/matrices/2x2_empty_diag_B.c ./$(BUILD_DIR)/kron_prod_with_mask.o \
	-o ./$(BUILD_DIR)/examples/2x2_empty_diag_B_with_mask.out -I/usr/local/include/suitesparse -lgraphblas

clean:
	$(RM) ./$(BUILD_DIR)/examples/*.out
	$(RM) ./$(BUILD_DIR)/*.o

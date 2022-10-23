#include<stdio.h>
#include<malloc.h>

void read_array(int* array, int size) {
        for(int i = 0; i < size; ++i) {
                scanf("%d", &array[i]);
        }
	return;
}

int count_valid(int* array, int size){
        int result_len = 0;
        for(int i = 0; i < size; ++i) {
                if (array[i] != array[0] && array[i] != array[size - 1]) {
                        ++result_len;
                }
        }
	return result_len;
}

void push_valid(int* result, int* array, int size) {
        int j = 0;
        for(int i = 0; i < size; ++i) {
                if (array[i] != array[0] && array[i] != array[size - 1]) {
                        result[j++] = array[i];
                }
        }
	return;
}

void print_array(int* array, int size){
        for(int i = 0; i < size; ++i) {
                printf("%d ", array[i]);
        }
	return;
}

int main(void) {
	int n;
	scanf("%d", &n);

	int* array = malloc(n * sizeof(int));
	read_array(array, n);

	int result_len = count_valid(array, n);
	int* result = malloc(result_len * sizeof(int));
	push_valid(result, array, n);

	print_array(result, result_len);

	free(array);
	free(result);
	return 0;
}

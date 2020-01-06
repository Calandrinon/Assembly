#include <stdio.h>

int maxnum(int*, int);

int main() {
	int v[200];
	int n;

	printf("Enter the size of the array: ");
	scanf("%d", &n);

	for (int i = 0; i < n; i++) {
		printf("Enter the element %d: ", i+1);
		scanf("%d", &v[i]);
	}

	FILE *f = fopen("max.txt", "w");

	fprintf(f, "The maximum value of the array in base 16 is: %x\n", maxnum(v,n));
	//printf("The maximum value of the array is: %x\n", maxnum(v, n));
	return 0;
}

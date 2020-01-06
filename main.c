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

	printf("The maximum value of the array is: %d\n", maxnum(v, n));
	return 0;
}

/*
int maxnum(int a[], int n) {
	int max_number = -(1<<30);

	for (int i = 0; i < n; i++) {
		if (a[i] > max_number) {
			max_number = a[i];
		}
	}

	return max_number;
}
*/

/*++
Write a C program that calls the function sumNumbers, written in assembly language. This functions receives
as parameters two integer numbers that were read in the C program, computes their sum and returns this value.
The C program will display the sum computed by the sumNumbers function.
--*/


#include <stdio.h>

// the function declased in the en_modulSumaNumere.asm file
int sum(int a, int b);

int main()
{
    // declare variables
    int a = 0; 
    int b = 0;
    int suma = 0;

    // read the two integers from the keyboard
    printf("a=");
    scanf("%d", &a);

    printf("b=");
    scanf("%d", &b);

    // call the function written in assembly language
    suma = sum(a, b);
    
    // display the result
    printf("Suma numerelor este %d", suma);
    
    return 0;
}


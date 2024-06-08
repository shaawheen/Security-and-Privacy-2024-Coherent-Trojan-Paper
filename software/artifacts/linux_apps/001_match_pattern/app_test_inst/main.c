#include "find_pa.h"

#define CACHE_LINE_SIZE 64

void dummyFunction() {
    int a = 5;
    int b = 10;
    int sum = a + b;
    int product = a * b;
    int quotient = b / a;
    int remainder = b % a;
    int negation = -sum;
    int bitwiseAnd = a & b;
    int bitwiseOr = a | b;
    int bitwiseXor = a ^ b;
    int leftShift = a << 2;
    int rightShift = b >> 1;
    int bitwiseNot = ~a;

    // Perform an operation with all variables
    int result = sum + product + quotient + remainder + negation + bitwiseAnd + bitwiseOr + bitwiseXor + leftShift + rightShift + bitwiseNot;
    printf("Result: %d\n", result);
}

int main(int argc, char *argv[]) {

    printf("Hello, World!\n");
    // +  CACHE_LINE_SIZE, because the pattern that I choose is not the same
    // as the &dummyFunction, but on the middle of the function
    getPhysicalAddress((void*)&dummyFunction+CACHE_LINE_SIZE); 
    dummyFunction();

    return 0;
}
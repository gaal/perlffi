#include <stdio.h>
typedef unsigned int uint;

int foo(int a) {
	return 1;
}

int func2(unsigned int i1, unsigned int i2) {
	printf("func2: arg1 = %u, arg2 = %u\n", i1, i2);
	return 0;
}

int func3(uint i1, uint i2, uint i3) {
	printf("func3: arg1 = %u, arg2 = %u, arg3 = %u\n", i1, i2, i3);
	return 0;
}


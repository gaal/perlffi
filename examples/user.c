#include <stdio.h>
#include <alloca.h>
int foo(int);

typedef struct {
	unsigned int ar[10];
} ar10;

typedef uint (*f10) (ar10 whatever);


uint sg_dispatcher_cdecl(void *func, uint *data, uint length, uint *result);

switch(length) {

	case 40:
		*(f10)(func)(*(ar10 *)data);
		


int func2(ar2 arg);
int func3(ar2 arg);

int main(void) {
	int c = foo(2);
	printf("foo(2) returned: %u\n", c);

	ar2 d;
	int i;
	for (i = 0; i < 10; i++) d.ar[i]=i;
	func2(d);
        func3(d);

	unsigned char *p = alloca(12);
	*(p+5) = 4;

	return 0;
}


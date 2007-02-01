#include <EXTERN.h>
#include <perl.h>
#include <XSUB.h>

#include "superglue.h"

MODULE = Superglue		PACKAGE = Superglue


void
sg_dispatch (call_conv, func_addr, ...)
	int	call_conv
	int	func_addr
PROTOTYPE: $$@
CODE:
{
	printf("sg_dispatch: callconv=%d, func_addr=%p\n",
			call_conv, func_addr);
	XSRETURN(1);
}



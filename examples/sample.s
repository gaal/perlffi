	.file	"sample.c"
	.text
.globl foo
	.type	foo, @function
foo:
	pushl	%ebp
	movl	%esp, %ebp
	movl	$1, %eax
	popl	%ebp
	ret
	.size	foo, .-foo
.globl fooc
	.type	fooc, @function
fooc:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	movl	8(%ebp), %eax
	movl	12(%ebp), %edx
	movb	%al, -4(%ebp)
	movb	%dl, -8(%ebp)
	movzbl	-4(%ebp), %edx
	movzbl	-8(%ebp), %eax
	leal	(%edx,%eax), %eax
	leave
	ret
	.size	fooc, .-fooc
	.ident	"GCC: (GNU) 4.0.3 (Ubuntu 4.0.3-1ubuntu5)"
	.section	.note.GNU-stack,"",@progbits

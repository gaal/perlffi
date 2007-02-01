	.file	"user.c"
	.section	.rodata
.LC0:
	.string	"foo(2) returned: %u\n"
	.text
.globl main
	.type	main, @function
main:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%edi
	pushl	%esi
	subl	$112, %esp
	andl	$-16, %esp
	movl	$0, %eax
	addl	$15, %eax
	addl	$15, %eax
	shrl	$4, %eax
	sall	$4, %eax
	subl	%eax, %esp
	movl	$2, (%esp)
	call	foo
	movl	%eax, -20(%ebp)
	movl	-20(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$.LC0, (%esp)
	call	printf
	movl	$0, -16(%ebp)
	jmp	.L2
.L3:
	movl	-16(%ebp), %edx
	movl	-16(%ebp), %eax
	movl	%eax, -60(%ebp,%edx,4)
	leal	-16(%ebp), %eax
	addl	$1, (%eax)
.L2:
	cmpl	$9, -16(%ebp)
	jle	.L3
	movl	%esp, %edi
	leal	-60(%ebp), %esi
	cld
	movl	$10, %eax
	movl	%eax, %ecx
	rep
	movsl
	call	func2
	movl	%esp, %edi
	leal	-60(%ebp), %esi
	cld
	movl	$10, %eax
	movl	%eax, %ecx
	rep
	movsl
	call	func3
	subl	$32, %esp
	leal	40(%esp), %eax
	movl	%eax, -76(%ebp)
	movl	-76(%ebp), %eax
	addl	$15, %eax
	shrl	$4, %eax
	sall	$4, %eax
	movl	%eax, -76(%ebp)
	movl	-76(%ebp), %eax
	movl	%eax, -12(%ebp)
	movl	-12(%ebp), %eax
	addl	$5, %eax
	movb	$4, (%eax)
	movl	$0, %eax
	leal	-8(%ebp), %esp
	popl	%esi
	popl	%edi
	popl	%ebp
	ret
	.size	main, .-main
	.ident	"GCC: (GNU) 4.0.3 (Ubuntu 4.0.3-1ubuntu5)"
	.section	.note.GNU-stack,"",@progbits

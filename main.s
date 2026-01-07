	.file	"main.c"
	.text
	.globl	builtins
	.section	.rodata
.LC0:
	.string	"echo"
.LC1:
	.string	"type"
.LC2:
	.string	"exit"
	.section	.data.rel.local,"aw"
	.align 16
	.type	builtins, @object
	.size	builtins, 24
builtins:
	.quad	.LC0
	.quad	.LC1
	.quad	.LC2
	.text
	.globl	_Z4echoPc
	.type	_Z4echoPc, @function
_Z4echoPc:
.LFB17:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movl	$4, %edx
	leaq	.LC0(%rip), %rcx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	strncmp@PLT
	testl	%eax, %eax
	je	.L2
	movl	$0, %eax
	jmp	.L3
.L2:
	movq	-8(%rbp), %rax
	addq	$5, %rax
	movq	%rax, %rdi
	call	puts@PLT
	movl	$1, %eax
.L3:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE17:
	.size	_Z4echoPc, .-_Z4echoPc
	.section	.rodata
.LC3:
	.string	"%s is a shell builtin\n"
.LC4:
	.string	"PATH"
.LC5:
	.string	"%s"
.LC6:
	.string	":"
.LC7:
	.string	"%s: not found\n"
	.text
	.globl	_Z4typePc
	.type	_Z4typePc, @function
_Z4typePc:
.LFB18:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$224, %rsp
	movq	%rdi, -216(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movq	-216(%rbp), %rax
	movl	$4, %edx
	leaq	.LC1(%rip), %rcx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	strncmp@PLT
	testl	%eax, %eax
	je	.L5
	movl	$0, %eax
	jmp	.L12
.L5:
	movq	-216(%rbp), %rax
	movl	$32, %esi
	movq	%rax, %rdi
	call	strchr@PLT
	movq	%rax, -184(%rbp)
	movl	$0, -200(%rbp)
	jmp	.L7
.L9:
	movl	-200(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	leaq	builtins(%rip), %rax
	movq	(%rdx,%rax), %rax
	movq	-184(%rbp), %rdx
	addq	$1, %rdx
	movq	%rax, %rsi
	movq	%rdx, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L8
	movq	-184(%rbp), %rax
	addq	$1, %rax
	movq	%rax, %rsi
	leaq	.LC3(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$1, %eax
	jmp	.L12
.L8:
	addl	$1, -200(%rbp)
.L7:
	cmpl	$2, -200(%rbp)
	jle	.L9
	leaq	.LC4(%rip), %rax
	movq	%rax, %rdi
	call	getenv@PLT
	movq	%rax, -192(%rbp)
	movq	-192(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC5(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$0, -196(%rbp)
	jmp	.L10
.L11:
	movl	-196(%rbp), %eax
	cltq
	movq	-176(%rbp,%rax,8), %rax
	movq	%rax, %rsi
	leaq	.LC5(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	addl	$1, -196(%rbp)
.L10:
	leaq	-192(%rbp), %rax
	leaq	.LC6(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strsep@PLT
	movl	-196(%rbp), %edx
	movslq	%edx, %rdx
	movq	%rax, -176(%rbp,%rdx,8)
	movl	-196(%rbp), %eax
	cltq
	movq	-176(%rbp,%rax,8), %rax
	testq	%rax, %rax
	setne	%al
	testb	%al, %al
	jne	.L11
	movq	-184(%rbp), %rax
	addq	$1, %rax
	movq	%rax, %rsi
	leaq	.LC7(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$1, %eax
.L12:
	movq	-8(%rbp), %rdx
	subq	%fs:40, %rdx
	je	.L13
	call	__stack_chk_fail@PLT
.L13:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE18:
	.size	_Z4typePc, .-_Z4typePc
	.section	.rodata
.LC8:
	.string	"$ "
.LC9:
	.string	"\n"
.LC10:
	.string	"%s: command not found\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB19:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$112, %rsp
	movl	%edi, -100(%rbp)
	movq	%rsi, -112(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
.L20:
	movq	stdout(%rip), %rax
	movl	$0, %esi
	movq	%rax, %rdi
	call	setbuf@PLT
	leaq	.LC8(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	stdin(%rip), %rdx
	leaq	-80(%rbp), %rax
	movl	$64, %esi
	movq	%rax, %rdi
	call	fgets@PLT
	leaq	-80(%rbp), %rax
	leaq	.LC9(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcspn@PLT
	movb	$0, -80(%rbp,%rax)
	leaq	-80(%rbp), %rax
	leaq	.LC2(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L15
	movl	$0, %edi
	call	exit@PLT
.L15:
	leaq	-80(%rbp), %rax
	movq	%rax, %rdi
	call	_Z4echoPc
	movb	%al, -82(%rbp)
	cmpb	$0, -82(%rbp)
	jne	.L22
	leaq	-80(%rbp), %rax
	movq	%rax, %rdi
	call	_Z4typePc
	movb	%al, -81(%rbp)
	cmpb	$0, -81(%rbp)
	jne	.L23
	leaq	-80(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC10(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	jmp	.L20
.L22:
	nop
	jmp	.L20
.L23:
	nop
	jmp	.L20
	.cfi_endproc
.LFE19:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:

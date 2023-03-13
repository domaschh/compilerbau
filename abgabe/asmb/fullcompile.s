	.file	"asma.c"
	.text
	.p2align 4
	.globl	asma
	.type	asma, @function
asma:
.LFB0:
	.cfi_startproc
	movq	%rdi, %r8 ; move argument 1 (rdi) ionto r8
	movq	%rsi, %rdi ; move argument 2 (rsi) into rdi
	testq	%rsi, %rsi ; argument 2 is now in rsi and we perform bitwise and and set the according flag

	je	.L14 ; jump if last arithmetic oeration was equal (ZF is set)
	leaq	-1(%rsi), %rcx
	cmpq	$62, %rcx
	jbe	.L13 ; jumpo beloq equal
	vmovdqa64	.LC0(%rip), %zmm4 ;moves 64 byets (512 bit) from .LC0 SRC to the zmm4 dest register
	movq	%rsi, %rdx ; second argument is moved from rsi to rdx
	movq	%r8, %rax ; first argument in r8 is moved to rax
	vmovdqa64	.LC1(%rip), %zmm3 ; second bitmask is move to zmm3
	vmovdqa64	.LC2(%rip), %zmm2 ; third bitmask is moved to zmm2
	andq	$-64, %rdx ;  (Aigns rdx 64 bit) bitwise and between value -6 and register rdx (second argument) (lowest 6 bits of rdx are set to 0? why) This instruction is often used to align the value in %rdx to a multiple of 64. The instruction effectively clears the least significant 6 bits of the value in %rdx, which ensures that the result is a multiple of 64.
	addq	%r8, %rdx ; adds r8 (first argument) to rdx (second argument) and stores result in rdx
	.p2align 4,,10
	.p2align 3
.L4:
	vpaddb	(%rax), %zmm4, %zmm1 ; adds rax (first argument) and the zmm4 bitmask and stores it in zmm1
	vpaddb	(%rax), %zmm2, %zmm0 ; adds rax (first argument) and the zmm2 bitmask and stores it in  zmm0
	addq	$64, %rax
	vpcmpub	$6, %zmm3, %zmm1, %k1 ; performes vector based unsigned byte comparison between two soruces and stores the result (according bit if true (1)) in the 64 bit destination mask register (k1), $6 specifies type and here means unsigned less than or equal 
	vmovdqu8	-64(%rax), %zmm0{%k1} ; selectively loads data from rax-64 into zmm0 based on the k1 mask 
	vmovdqu8	%zmm0, -64(%rax) ; moves the result from zmm0 back into rax-64
	cmpq	%rax, %rdx ; compare rax (now first bitmask applied) with rdx second argument
	jne	.L4
	movq	%rdi, %rdx  ; rdx(123123) -> movq rdx, rax ? rdx(??????) & rax (123123)
	andq	$-64, %rdx
	testb	$63, %dil
	je	.L17
.L3:
	movq	%rdi, %rsi
	subq	%rdx, %rcx
	subq	%rdx, %rsi
	cmpq	$30, %rcx
	jbe	.L11
	leaq	(%r8,%rdx), %rax
	vmovdqu8	(%rax), %xmm5
	vinserti128	$0x1, 16(%rax), %ymm5, %ymm0
	vpaddb	.LC3(%rip), %ymm0, %ymm2
	vpaddb	.LC5(%rip), %ymm0, %ymm1
	vpcmpub	$6, .LC4(%rip), %ymm2, %k1
	vmovdqu8	%ymm0, %ymm1{%k1}
	vmovdqu8	%xmm1, (%rax)
	vextracti128	$0x1, %ymm1, 16(%rax) ;  extract upper 128 bits (specified by $0x1) from ymm1 to rax  + 16
	movq	%rsi, %rax
	andq	$-32, %rax
	addq	%rax, %rdx
	cmpq	%rax, %rsi
	je	.L17
	.p2align 4,,10
	.p2align 3
.L11:
	movzbl	(%r8,%rdx), %eax
	leal	-97(%rax), %esi
	leal	-32(%rax), %ecx
	cmpb	$26, %sil
	cmovb	%ecx, %eax
	movb	%al, (%r8,%rdx)
	addq	$1, %rdx
	cmpq	%rdx, %rdi
	ja	.L11
.L17:
	vzeroupper
.L14:
	movq	%r8, %rax
	ret
.L13:
	xorl	%edx, %edx
	jmp	.L3
	.cfi_endproc
.LFE0:
	.size	asma, .-asma
	.section	.rodata
	.align 64
.LC0:
	.byte	-97
	.byte	-97
	.byte	-97
	.byte	-97
	.byte	-97
	.byte	-97
	.byte	-97
	.byte	-97
	.byte	-97
	.byte	-97
	.byte	-97
	.byte	-97
	.byte	-97
	.byte	-97
	.byte	-97
	.byte	-97
	.byte	-97
	.byte	-97
	.byte	-97
	.byte	-97
	.byte	-97
	.byte	-97
	.byte	-97
	.byte	-97
	.byte	-97
	.byte	-97
	.byte	-97
	.byte	-97
	.byte	-97
	.byte	-97
	.byte	-97
	.byte	-97
	.byte	-97
	.byte	-97
	.byte	-97
	.byte	-97
	.byte	-97
	.byte	-97
	.byte	-97
	.byte	-97
	.byte	-97
	.byte	-97
	.byte	-97
	.byte	-97
	.byte	-97
	.byte	-97
	.byte	-97
	.byte	-97
	.byte	-97
	.byte	-97
	.byte	-97
	.byte	-97
	.byte	-97
	.byte	-97
	.byte	-97
	.byte	-97
	.byte	-97
	.byte	-97
	.byte	-97
	.byte	-97
	.byte	-97
	.byte	-97
	.byte	-97
	.byte	-97
	.align 64
.LC1:
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.align 64
.LC2:
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.section	.rodata.cst32,"aM",@progbits,32
	.align 32
.LC3:
	.byte	-97
	.byte	-97
	.byte	-97
	.byte	-97
	.byte	-97
	.byte	-97
	.byte	-97
	.byte	-97
	.byte	-97
	.byte	-97
	.byte	-97
	.byte	-97
	.byte	-97
	.byte	-97
	.byte	-97
	.byte	-97
	.byte	-97
	.byte	-97
	.byte	-97
	.byte	-97
	.byte	-97
	.byte	-97
	.byte	-97
	.byte	-97
	.byte	-97
	.byte	-97
	.byte	-97
	.byte	-97
	.byte	-97
	.byte	-97
	.byte	-97
	.byte	-97
	.align 32
.LC4:
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.align 32
.LC5:
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.ident	"GCC: (Debian 10.2.1-6) 10.2.1 20210110"
	.section	.note.GNU-stack,"",@progbits

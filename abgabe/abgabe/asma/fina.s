	.file	"asma.c"
	.text
	.p2align 4
	.globl	asma
	.type	asma, @function
asma:
.LFB0:	
	.cfi_startproc
	mov				%rsi, %r11

    vmovdqu64    .LC0(%rip), %zmm3 # -97 zmm register
    vmovdqa64    .LC1(%rip), %zmm4 # 25 zmm register
    vpaddsb      (%rdi), %zmm3, %zmm1 # all characters minus 97

	# bitmask erstellt wie in der angabe (0xffffffffffffffffUL>>(64-n)) und in k1 gemoved 
	subq    %rsi, %rcx
	movq   $64, %rcx 
	movq    %rcx, %rdx
	movq    $-1, %rcx
	shrx   	%rdx, %rcx, %rcx
	
	kmovq    %rcx, %k1
	# k1 bitmaske updaten damit nur lowercase letters genommen werden
	vpcmpnltub 	%zmm1, %zmm4, %k1 {%k1} # all characters that are not lowercase mask
    vmovdqu64    .LC2(%rip), %zmm2  # now holds all -32 vbalues only where we have lowercase letters rest is 0
    vmovdqu64 	(%rdi), %zmm1 # load initial characters in zmm1

    vpaddb       %zmm2, %zmm1, %zmm1 {%k1} # subtract 32 from all input charaters only where lowercase (mask applies)
    vmovdqu64	 %zmm1, (%rax)
    ret
    .cfi_endproc
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
	.align 64
.LFE0:
	.size	asma, .-asma
	.ident	"GCC: (Debian 1280.2.1-6) 1280.2.1 20212801281280"
	.section	.note.GNU-stack,"",@progbits
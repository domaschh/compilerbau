.file    "asmb.s"
    .text
    .p2align 4
    .globl    asmb
    .type    asmb, @function
asmb:
.LFB0:    
    .cfi_startproc
    vmovdqu64    .LC0(%rip), %zmm3 # -97 zmm register
    vmovdqa64    .LC1(%rip), %zmm4 # 25 zmm register

    movq    $0, %r10 # offset for loading characters
    movq    %rsi, %r11 # ueberige n 
	  
loop_start:
	movq   $-1, %r8 # initialize for k1
    kmovq   %r8, %k1  
    cmpq    $64, %r11
    jg     skip_shift # wenn groesser als 64 brauch ma mask shift nd

    # bitmask erstellt wie in der angabe (0xffffffffffffffffUL>>(64-n)) und in k1 gemoved 
	movq   $64, %rcx 
	subq    %rsi, %rcx
	movq    %rcx, %rdx
	movq    $-1, %rcx
	shrx   	%rdx, %rcx, %rcx
	kmovq    %rcx, %k1

skip_shift:
	vpaddsb	(%rdi,%r10), %zmm3, %zmm1 # all characters minus 97
	# k1 bitmaske updaten damit nur lowercase letters genommen werden
	vpcmpnltub 	%zmm1, %zmm4, %k1 {%k1} # all characters that are not lowercase mask
    vmovdqu64    .LC2(%rip), %zmm2  # now holds all -32 vbalues only where we have lowercase letters rest is 0
    vmovdqu64 	(%rdi, %r10), %zmm1 # load initial characters in zmm1

    vpaddb       %zmm2, %zmm1, %zmm1 {%k1} # subtract 32 from all input charaters only where lowercase (mask applies)
    vmovdqu64	 %zmm1, (%rax, %r10)

    subq    $64, %r11 # increase offset
    addq    $64, %r10 # decrease times to loop
    cmpq    $0, %r11  # set compareflag to see if loop
    jg      loop_start

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
	.size	asmb, .-asmb
	.ident	"GCC: (Debian 1280.2.1-6) 1280.2.1 20212801281280"
	.section	.note.GNU-stack,"",@progbits
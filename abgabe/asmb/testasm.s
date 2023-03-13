	.file	"asma.c"
	.text
	.p2align 4
	.globl	asma
	.type	asma, @function
asma:
.LFB0:
	.cfi_startproc
	; rdi = pointer to string
    ; rsi = string length
    ; zmm0 = uppercase mask (0x2020202020202020)
    ; zmm1 = lowercase mask (0x0000000000202020)
    ; zmm2 = input string in 64-byte chunks
    ; zmm3 = output string in 64-byte chunks
    
    ; Load masks
    mov rax, 0x2020202020202020
    movq zmm0, rax
    mov rax, 0x0000000000202020
    movq zmm1, rax
    
    ; Calculate number of 64-byte chunks
    mov rdx, rsi
    shr rdx, 6  ; rdx = rsi / 64
    
    ; Copy input string to output string
    vmovdqu64 zmm3, [rdi]
    
    ; Apply lowercase mask to input string
    vpand zmm3, zmm1, zmm3
    
    ; Apply uppercase mask to input string
    vpxor zmm3, zmm3, zmm0
    
    ; Store output string
    vmovdqu64 [rdi], zmm3
    
    ; Handle remaining bytes
    and rsi, 63
    jz .end
    
    ; Load remaining bytes of input string into zmm2
    movq rax, [rdi+rdx*64]
    movq zmm2, rax
    vpermq zmm2, zmm2, 0x00
    
    ; Apply lowercase mask to input string
    vpand zmm2, zmm1, zmm2
    
    ; Apply uppercase mask to input string
    vpxor zmm2, zmm2, zmm0
    
    ; Store remaining bytes of output string
    movq [rdi+rdx*64], zmm2
	ret
	.cfi_endproc
.LFE0:
	.size	asma, .-asma
	.ident	"GCC: (Debian 1280.2.1-6) 1280.2.1 20212801281280"
	.section	.note.GNU-stack,"",@progbits

.section .rodata
.align 64
.LC0:
	.byte	128
	.byte	128
	.byte	128
	.byte	128
	.byte	128
	.byte	128
	.byte	128
	.byte	128
	.byte	128
	.byte	128
	.byte	128
	.byte	128
	.byte	128
	.byte	128
	.byte	128
	.byte	128
	.byte	128
	.byte	128
	.byte	128
	.byte	128
	.byte	128
	.byte	128
	.byte	128
	.byte	128
	.byte	128
	.byte	128
	.byte	128
	.byte	128
	.byte	128
	.byte	128
	.byte	128
	.byte	128
	.byte	128
	.byte	128
	.byte	128
	.byte	128
	.byte	128
	.byte	128
	.byte	128
	.byte	128
	.byte	128
	.byte	128
	.byte	128
	.byte	128
	.byte	128
	.byte	128
	.byte	128
	.byte	128
	.byte	128
	.byte	128
	.byte	128
	.byte	128
	.byte	128
	.byte	128
	.byte	128
	.byte	128
	.byte	128
	.byte	128
	.byte	128
	.byte	128
	.byte	128
	.byte	128
	.byte	128
	.byte	128
	.align 64
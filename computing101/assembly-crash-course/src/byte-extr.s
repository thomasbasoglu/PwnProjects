.intel_syntax noprefix
.global _start

.section .text 

_start:
    mov rax, rdi
    shr rax, 32
    mov rbx, 0
    mov bl, al
    mov rax, rbx
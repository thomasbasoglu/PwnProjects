.intel_syntax noprefix
.global _start

.section .text 

_start:
    mov rax, 0x403000
    jmp rax
.intel_syntax noprefix
.global _start

.section .text 

_start:
    mov rax, rdi
    cqo
    idiv rsi
    mov rax,rdx


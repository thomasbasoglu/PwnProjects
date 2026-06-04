.intel_syntax noprefix
.global _start

.section .text 

_start:
    and rdi, 1
    and rax, rdi
    xor rax, 1
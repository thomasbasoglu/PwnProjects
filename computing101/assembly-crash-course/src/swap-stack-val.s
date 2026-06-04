.intel_syntax noprefix
.global _start

.section .text 

_start:
    push rsi
    push rdi
    pop rsi 
    pop rdi


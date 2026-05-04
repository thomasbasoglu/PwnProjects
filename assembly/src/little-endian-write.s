.intel_syntax noprefix
.global _start

.section .text 

_start:
    mov r8, 0xdeadbeef00001337
    mov r9, 0xc0ffee0000
    mov [rdi], r8 
    mov [rsi], r9
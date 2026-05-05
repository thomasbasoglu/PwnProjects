.intel_syntax noprefix
.global _start

.section .text 

_start:
    pop rsi
    sub rsi, rdi
    push rsi

    # the glamorous exit
    mov rax, 60
    xor rdi, rdi 
    syscall
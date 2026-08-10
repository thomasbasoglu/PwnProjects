.intel_syntax noprefix
.global _start

_start:
    lea rdi, [rip + path]
    mov rax, 2
    syscall

    mov rdi, rax
    mov rsi, rsp
    mov rdx, 128
    mov rax, 0
    syscall

    mov rdx, rax
    mov rdi, 1
    mov rsi, rsp
    mov rax, 1
    syscall

    mov rdi, 42
    mov rax, 60
    syscall

path:
    .asciz "/flag"

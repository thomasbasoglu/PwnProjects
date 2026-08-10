.intel_syntax noprefix
.global _start

.section .text 

_start:
    mov rdi, [rsp]
    cmp rdi, 42
    setz dil

    mov rax, 60
    syscall

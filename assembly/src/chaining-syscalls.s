.intel_syntax noprefix
.global _start

.section .text 

_start:
    mov rsi, [rsp+16]     # Loading the first instruct into rsi
    mov rax, 1            # setting Accumulator or return value to 1
    mov rdi, 1            # setting Destination index to 1
    mov rdx, 1            # setting data to 1
    syscall

    mov rax, 60            # syscall number 
    mov rdi, 42            # It was asking to set rdi to 42
    syscall                
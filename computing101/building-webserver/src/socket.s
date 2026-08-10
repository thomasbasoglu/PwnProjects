.intel_syntax noprefix
.global _start

.section .text 

_start:
    mov rax, 41     # syscall for socket
    mov rdi, 2      # family AF_INET
    mov rsi, 1      # type is SOCK_STREAM
    mov rdx, 0      # protocol IPPROTO_IP
    syscall

    mov rax, 60     # exits
    xor rdi, rdi    # reset the rdi
    syscall
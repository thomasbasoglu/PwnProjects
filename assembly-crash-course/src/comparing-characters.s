.intel_syntax noprefix
.global _start

.section .text 

_start:
    mov rax, [rsp+16]       # Recalling from stack the agv[1]
    cmp BYTE PTR [rax], 'p' # Comparing the value
    setz dil                # Getting the first 8 bits of the 64bit where
                            # result is stored
    mov rax, 60
    syscall

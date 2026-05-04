.intel_syntax noprefix
.global _start

.section .text 

_start:
    mov rax, [rsp+16]       # Recalling from stack the agv[1]
    cmp BYTE PTR [rax], 'p' # Comparing the value
    jne _fail               # jump if not equal to then run fail
                            
    # Lines run if the program returns true
    mov rdi, 0
    jmp _exit
# Fail definition
_fail:
    mov rdi, 1
    syscall


# The GLAMOROUSSSS exit
_exit:
    mov rax, 60
    syscall
.intel_syntax noprefix
.global _start

.section .text 

_start:
    mov rax, [rsp+16]       # Recalling from stack the agv[1]
    cmp BYTE PTR [rax], 0x70 # Comparing the value p
    jne _fail               # Jump if not equal to then fail run

    cmp BYTE PTR [rax+1], 0x77 # Comparing the value w
    jne _fail               # Jump if not equal to then fail run
    
    cmp BYTE PTR [rax+2], 0x6e # Comparing the value n
    jne _fail               # Jump if not equal to then fail run
    
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
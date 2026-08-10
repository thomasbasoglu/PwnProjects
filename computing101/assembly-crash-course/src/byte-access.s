.intel_syntax noprefix
.global _start

.section .text 

_start:
    xor rax, rax 
    mov al, [0x404000]

    # movzx rax, byte ptr [0x404000] does similar 

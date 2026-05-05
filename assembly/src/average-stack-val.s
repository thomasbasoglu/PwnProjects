.intel_syntax noprefix
.global _start

.section .text 

_start:
    # Getting the quad words
    mov rax, [rsp]
    mov rbx, [rsp + 0x08]
    mov rcx, [rsp + 0x10]
    mov rdx, [rsp + 0x18]

    # Adding into the same registers 
    add rax, rbx
    add rcx, rdx
    add rax, rcx

    # Divide by 4
    shr rax, 2

    # Shifting the stack pointer and copying the data same as push rax
    sub rsp, 8
    mov [rsp], rax


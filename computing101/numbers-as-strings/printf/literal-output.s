.intel_syntax noprefix
.global _start

.text

_start:
    mov rbx, [rsp + 16]

loop:
    mov al, byte ptr [rbx]
    test al, al
    jz done

    mov rax, 1
    mov rdi, 1
    lea rsi, [rbx]
    mov rdx, 1
    syscall

    inc rbx
    jmp loop

done:
    mov rax, 60
    xor rdi, rdi
    syscall

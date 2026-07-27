.intel_syntax noprefix
.global _start

.text
_start:
    mov rdi, [rsp+16]
    xor rax, rax

count_loop:
    cmp byte ptr [rdi+rax], 0
    je done
    inc rax
    jmp count_loop

done:
    mov rdi, rax
    mov rax, 60
    syscall



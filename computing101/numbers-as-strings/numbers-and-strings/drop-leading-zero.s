 .intel_syntax noprefix
.globl itoa
.text

itoa:
    mov rax, rdi
    cmp rax, 0
    jne not_zero

    mov byte ptr [rsi], '0'
    mov rax, 1
    ret

not_zero:
    mov rcx, 10
    xor rdx, rdx
    div rcx

    cmp rax, 0
    jne two_digits

    add dl, '0'
    mov byte ptr [rsi], dl
    mov rax, 1
    ret

two_digits:
    add al, '0'
    mov byte ptr [rsi], al

    add dl, '0'
    mov byte ptr [rsi + 1], dl

    mov rax, 2
    ret



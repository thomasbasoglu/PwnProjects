.intel_syntax noprefix
.global _start

.text

atoi:
    xor rax, rax
    xor r8, r8              # sign flag (0 = +, 1 = -)

    movzx rdx, byte ptr [rdi]
    cmp dl, '-'
    jne atoi_loop
    mov r8, 1
    inc rdi

atoi_loop:
    movzx rdx, byte ptr [rdi]
    test rdx, rdx
    jz atoi_done

    sub rdx, '0'
    imul rax, rax, 10
    add rax, rdx

    inc rdi
    jmp atoi_loop

atoi_done:
    cmp r8, 0
    je atoi_ret
    neg rax

atoi_ret:
    ret


itoa:
    push rbx

    mov rbx, 0              # length counter

    cmp rdi, 0
    jge itoa_positive

    mov byte ptr [rsi], '-'
    inc rsi
    inc rbx
    neg rdi

itoa_positive:
    cmp rdi, 0
    jne itoa_convert

    mov byte ptr [rsi], '0'
    mov rax, 1
    pop rbx
    ret

itoa_convert:
    xor rcx, rcx            # digit count

itoa_loop:
    cmp rdi, 0
    je itoa_write

    mov rax, rdi
    xor rdx, rdx
    mov r10, 10
    div r10

    push rdx
    inc rcx
    mov rdi, rax
    jmp itoa_loop

itoa_write:
    mov rax, rcx
    add rax, rbx            # include sign if needed

    xor rbx, rbx

itoa_write_loop:
    cmp rcx, 0
    je itoa_done

    pop rdx
    add dl, '0'
    mov byte ptr [rsi + rbx], dl

    inc rbx
    dec rcx
    jmp itoa_write_loop

itoa_done:
    pop rbx
    ret



# MAIN

_start:
    mov rbx, [rsp]          # argc
    lea rsi, [rsp + 16]     # argv[1]

    xor r12, r12            # sum = 0
    mov rcx, rbx
    dec rcx                 # argc - 1

argv_loop:
    cmp rcx, 0
    je sum_done

    mov rdi, [rsi]
    call atoi

    add r12, rax

    add rsi, 8
    dec rcx
    jmp argv_loop

sum_done:
    mov rdi, r12

    sub rsp, 64
    mov rsi, rsp

    call itoa

    mov rdx, rax            # length
    mov rax, 1              # write
    mov rdi, 1
    mov rsi, rsp
    syscall

    mov rax, 60             # exit
    xor rdi, rdi
    syscall


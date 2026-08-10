.intel_syntax noprefix
.global _start

.text

atoi:
    xor rax, rax
    xor r8, r8

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
    mov rbx, 0

    cmp rdi, 0
    jge itoa_pos

    mov byte ptr [rsi], '-'
    inc rsi
    inc rbx
    neg rdi

itoa_pos:
    cmp rdi, 0
    jne itoa_conv

    mov byte ptr [rsi], '0'
    mov rax, 1
    pop rbx
    ret

itoa_conv:
    xor rcx, rcx

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
    add rax, rbx

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


_start:
    mov rbx, rsp
    mov rax, [rbx]          # argc

    cmp rax, 4
    je binary_mode

    cmp rax, 3
    je unary_mode

    mov rax, 60
    mov rdi, 1
    syscall


binary_mode:
    mov rdi, qword ptr [rbx + 24]
    movzx r9d, byte ptr [rdi]

    mov rdi, qword ptr [rbx + 16]
    call atoi
    mov r12, rax

    mov rdi, qword ptr [rbx + 32]
    call atoi

    cmp r9b, '+'
    je b_add
    cmp r9b, '-'
    je b_sub
    cmp r9b, '*'
    je b_mul
    cmp r9b, '^'
    je b_xor
    cmp r9b, '|'
    je b_or
    cmp r9b, '&'
    je b_and

    mov rax, 60
    mov rdi, 1
    syscall

b_add:
    add r12, rax
    jmp done

b_sub:
    sub r12, rax
    jmp done

b_mul:
    imul r12, rax
    jmp done

b_xor:
    xor r12, rax
    jmp done

b_or:
    or r12, rax
    jmp done

b_and:
    and r12, rax
    jmp done


unary_mode:
    mov rdi, qword ptr [rbx + 16]
    movzx r9d, byte ptr [rdi]

    mov rdi, qword ptr [rbx + 24]
    call atoi
    mov r12, rax

    cmp r9b, '-'
    je u_neg
    cmp r9b, '~'
    je u_not

    mov rax, 60
    mov rdi, 1
    syscall

u_neg:
    neg r12
    jmp done

u_not:
    not r12


done:
    sub rsp, 0x80
    mov rsi, rsp

    mov rdi, r12
    call itoa

    mov rdx, rax
    mov rax, 1
    mov rdi, 1
    mov rsi, rsp
    syscall

    mov rax, 60
    xor rdi, rdi
    syscall

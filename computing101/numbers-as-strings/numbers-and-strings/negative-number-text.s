.intel_syntax noprefix
.global itoa

.text

itoa:
    push rbx

    mov rbx, 0              # length = 0

    cmp rdi, 0
    jge .positive

    # negative case
    mov byte ptr [rsi], '-'
    inc rsi
    inc rbx

    neg rdi                 # make magnitude positive

.positive:
    cmp rdi, 0
    jne .start

    mov byte ptr [rsi], '0'
    mov rax, 1
    pop rbx
    ret

.start:
    mov rcx, 0              # digit count

.loop:
    cmp rdi, 0
    je .write

    mov rax, rdi
    xor rdx, rdx
    mov r8, 10
    div r8                  # rax = quotient, rdx = remainder

    push rdx
    inc rcx

    mov rdi, rax
    jmp .loop

.write:
    mov rax, rcx
    add rax, rbx            # add sign length if negative

    xor rbx, rbx

.write_loop:
    cmp rcx, 0
    je .done

    pop rdx
    add dl, '0'
    mov byte ptr [rsi + rbx], dl

    inc rbx
    dec rcx
    jmp .write_loop

.done:
    pop rbx
    ret


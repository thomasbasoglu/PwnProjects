.intel_syntax noprefix
.global itoa

.text

itoa:
    push rbx                # preserve callee-saved register

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
    mov rbx, 10
    div rbx                 # rax=quotient, rdx=remainder

    push rdx
    inc rcx

    mov rdi, rax
    jmp .loop

.write:
    mov rax, rcx
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
    pop rbx                 # restore
    ret


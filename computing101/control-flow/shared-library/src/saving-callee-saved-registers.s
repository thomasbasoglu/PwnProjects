.intel_syntax noprefix
.global solve

solve:
    # 1. Save all callee-saved registers (6 registers = 48 bytes)
    push rbx
    push rbp
    push r12
    push r13
    push r14
    push r15

    # 2. Save the function pointer (rdi) to a register that ISN'T 
    mov rax, rdi

    # 3. Align stack
    sub rsp, 8

    # 4. Clobber the registers
    mov rbx, 0x1337
    mov rbp, 0x1337
    mov r12, 0x1337
    mov r13, 0x1337
    mov r14, 0x1337
    mov r15, 0x1337

    # 5. Call the function
    call rax

    # 6. Restore stack
    add rsp, 8

    # 7. Restore registers in reverse order
    pop r15
    pop r14
    pop r13
    pop r12
    pop rbp
    pop rbx

    ret
    
.intel_syntax noprefix
.global solve

solve:
    # Save all caller-saved registers onto the stack
    push rax
    push rcx
    push rdx
    push rsi
    push rdi
    push r8
    push r9
    push r10
    push r11

    # Ensure stack alignment 
    sub rsp, 8

    # Callthe clobber func
    
    mov r12, rdi # clobber_function
    mov r13, rsi # flag_function

    call r12

    # Restore the stack alignment
    add rsp, 8

    # Restore caller-saved registers in reverse order
    pop r11
    pop r10
    pop r9
    pop r8
    pop rdi
    pop rsi
    pop rdx
    pop rcx
    pop rax

    # Call the flag_function
    call r13
    
    ret

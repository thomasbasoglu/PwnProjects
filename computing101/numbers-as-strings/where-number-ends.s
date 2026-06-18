.intel_syntax noprefix
.global atoi

atoi:
    xor rax, rax
    xor r8, r8
    mov rcx, 10

    # Check for negative sign
    mov dl, byte ptr [rdi]
    cmp dl, 0x2d
    jne loop_start
    mov r8, 1
    inc rdi

loop_start:
    movzx rdx, byte ptr [rdi]
    
    # Digit check and convert
    sub rdx, 0x30
    
    # Check if the value is less than 9 
    # If the character was < '0' or > '9', this will be above 9.
    cmp rdx, 9
    ja loop_end        # Stop if it's not a digit
    
    # Standard Math (Digit is safe in rdx)
    push rdx           # Save digit
    mov rax, rax       
    mul rcx            # rax = rax * 10
    pop rdx            # Restore digit
    add rax, rdx       # Add digit to total
    
    inc rdi 
    jmp loop_start
    
loop_end:
    test r8, r8
    jz done 
    neg rax 

done:
    ret

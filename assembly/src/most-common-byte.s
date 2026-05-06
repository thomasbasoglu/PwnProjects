.intel_syntax noprefix
.global most_common_byte

most_common_byte:
    # rdi = src_addr, rsi = size
    push rbx
    push r12
    push r13

    # Allocate 512 bytes for the table
    sub rsp, 512

    mov rcx, 512
zero_loop:
    mov byte ptr [rsp + rcx - 1], 0
    loop zero_loop

    xor rcx, rcx            # i = 0
count_loop:
    cmp rcx, rsi            # while i < size
    je find_max_init
    
    movzx rax, byte ptr [rdi + rcx] # Get the byte at src_addr + i
    inc word ptr [rsp + rax * 2]    # Increment the 16-bit counter for that byte
    
    inc rcx
    jmp count_loop

find_max_init:
    xor rcx, rcx            # b = 0 (current byte being checked)
    xor dx, dx              # dx = max_freq
    xor r8, r8              # r8 = max_freq_byte

    # --- 3. The Maximum Search Loop ---
find_max_loop:
    cmp rcx, 256            # Check all bytes from 0-255
    je final_exit

    mov ax, [rsp + rcx * 2] # Load the 16-bit frequency
    cmp ax, dx              # Compare current frequency with max_freq
    jbe next_iteration      # If frequency <= max_freq, move on

    mov dx, ax              # Update max_freq
    mov r8, rcx             # Update max_freq_byte

next_iteration:
    inc rcx
    jmp find_max_loop

final_exit:
    mov rax, r8             # Put the resulting byte into rax
    add rsp, 512            # Cleanup stack
    pop r13
    pop r12
    pop rbx
    ret
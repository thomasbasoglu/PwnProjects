.intel_syntax noprefix
.global solve 

solve:
	# Reverse 256 bytes
	sub rsp, 256

	# Initialize 256 bytes to 0
	mov rcx, 0

clear_loop:
	mov byte ptr [rsp + rcx], 0
	inc rcx
	cmp rcx, 256
	jne clear_loop

	xor rcx, rcx

mark_loop:
    cmp rcx, rsi
    je count_start
    
    # Load byte from buffer [rdi + rcx] into a temporary register
    movzx rdx, byte ptr [rdi + rcx]
    
    # Mark this slot as 1 in our stack scratchpad
    mov byte ptr [rsp + rdx], 1
    
    inc rcx
    jmp mark_loop

    # Count how many slots are marked as 1
count_start:
    xor rax, rax      # rax will be our return value (total count)
    xor rcx, rcx      # rcx = current index in tally array (0 to 255)
count_loop:
    cmp byte ptr [rsp + rcx], 1
    jne skip_count
    inc rax
skip_count:
    inc rcx
    cmp rcx, 256
    jne count_loop

    # Clean up: Restore the stack and return
    add rsp, 256
    ret

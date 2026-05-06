.intel_syntax noprefix


_start:
    # 1. Setup
    mov rcx, rsi        # Use rcx as our loop counter (n)
    mov rbx, rsi        # Save a copy of n for the division later
    xor rax, rax        # Clear rax to hold the running sum

    # 2. Check for Zero (Always safe to do)
    test rcx, rcx
    jz done

    # 3. Summation Loop
sum_loop:
    add rax, [rdi]      # Add the quadword at the current address to rax
    add rdi, 8          # Move pointer to the next quadword
    dec rcx             # Decrement the counter
    jnz sum_loop        # Repeat until rcx is 0

    # 4. Average
    # rax now has the total sum. Divide by rbx (original n).
    cqo                 # Sign-extend rax into rdx:rax
    idiv rbx            # rax = rax / rbx

done:
    # rax now contains the average. 
    # No need for syscall or extra moves unless specified.
    # The challenge environment usually handles the exit.
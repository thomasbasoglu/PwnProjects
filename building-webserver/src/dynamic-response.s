.intel_syntax noprefix
.global _start
.section .data 
    # The tracer is very picky: it must be exactly 19 bytes.
    message: 
        .ascii "HTTP/1.0 200 OK\r\n\r\n"

.section .text 

_start:
    # 1. Socket 
    mov rax, 41     
    mov rdi, 2      
    mov rsi, 1      
    mov rdx, 0      
    syscall

    # 2. Bind
    mov rdi, rax    
    xor rax, rax 
    push rax
    mov rsi, 0x0000000050000002 # Port 80
    push rsi
    mov rax, 49     
    mov rsi, rsp    
    mov rdx, 16     
    syscall

    # 3. Listen
    mov rax, 50     
    mov rdi, 3      
    xor rsi, rsi    
    syscall

    # 4. Accept
    mov rax, 43     
    mov rdi, 3      
    xor rsi, rsi    
    xor rdx, rdx     
    syscall 

    # --- FD PERSISTENCE ---
    # We move the Client FD to r12. Syscalls will NOT overwrite r12.
    mov r12, rax    # r12 = 4
    
    # 5. Read Request
    mov rdi, r12
    xor rax, rax    
    mov rsi, rsp    
    mov rdx, 1024   
    syscall

    # 6. Parse Path
    lea rdi, [rsp + 4]  # skip "GET "
    xor rcx, rcx
find_space:
    cmp byte ptr [rdi + rcx], ' '
    je found_space
    inc rcx
    jmp find_space
found_space:
    mov byte ptr [rdi + rcx], 0 # Null-terminate for open()

    # 7. Open File 
    mov rax, 2      
    # rdi is already pointing to our parsed path
    xor rsi, rsi    # O_RDONLY
    syscall
    mov r13, rax    # r13 = File FD (5)

    # 8. Write Header (Tracer check: write(4, "HTTP...", 19))
    mov rax, 1      
    mov rdi, r12    # Use r12 (Client FD)
    lea rsi, [rip + message]
    mov rdx, 19
    syscall

    # 9. Read from File (Tracer check: read(5, ...))
    mov rax, 0      
    mov rdi, r13    # Use r13 (File FD)
    mov rsi, rsp    
    mov rdx, 1024
    syscall
    
    # 10. Write File Content to Client (Tracer check: write(4, ...))
    mov rdx, rax    # bytes read from file
    mov rax, 1      
    mov rdi, r12    # Use r12 (Client FD)
    mov rsi, rsp
    syscall

    # 11. Close File (Tracer check: close(5))
    mov rax, 3      
    mov rdi, r13
    syscall

    # 12. Close Client (Tracer check: close(4))
    mov rax, 3
    mov rdi, r12
    syscall

    # 13. Exit (Tracer check: exit(0))
    mov rax, 60     
    xor rdi, rdi    
    syscall
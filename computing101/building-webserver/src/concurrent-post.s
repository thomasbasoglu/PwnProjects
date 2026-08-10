.intel_syntax noprefix
.global _start

.section .data
header: .ascii "HTTP/1.0 200 OK\r\n\r\n"

.section .text
_start:
    # Setup listening socket
    mov rdi, 2
    mov rsi, 1
    xor rdx, rdx
    mov rax, 41
    syscall
    mov r15, rax

    # Bind socket to port 80
    xor rax, rax
    push rax
    movw [rsp-2], 0x5000
    movw [rsp-4], 2
    sub rsp, 4
    mov rdi, r15
    lea rsi, [rsp]
    mov rdx, 16
    mov rax, 49
    syscall

    # Set socket to listening mode
    mov rdi, r15
    xor rsi, rsi
    mov rax, 50
    syscall

.request_loop:
    # Accept incoming connection
    mov rdi, r15
    xor rsi, rsi
    xor rdx, rdx
    mov rax, 43
    syscall
    mov r14, rax

    # Fork process to handle request concurrently
    mov rax, 57
    syscall
    test rax, rax
    jnz .parent_process

.child_process:
    # 1. Close listener
    mov rdi, r15
    mov rax, 3
    syscall

    # 2. Read request
    sub rsp, 0x1000
    mov rdi, r14
    mov rsi, rsp
    mov rdx, 0x1000
    xor rax, rax
    syscall
    mov r13, rax

    # 3. Extract filename
    lea rdi, [rsp+5]
    xor rax, rax
.file_name_loop:
    cmpb [rdi+rax], 0x20
    je .end_file_name_loop
    inc rax
    jmp .file_name_loop
.end_file_name_loop:
    movb [rdi+rax], 0x0

    # 4. Find Body
    lea rsi, [rsp]
.find_body:
    cmpb [rsi], 0x0d
    jne .next_byte
    cmpb [rsi+1], 0x0a
    jne .next_byte
    cmpb [rsi+2], 0x0d
    jne .next_byte
    cmpb [rsi+3], 0x0a
    je .found_body
.next_byte:
    inc rsi
    jmp .find_body
.found_body:
    add rsi, 4
    mov r10, rsi        # Save body start address in r11

    # 5. Open file
    lea rdi, [rsp+5]
    mov rsi, 0x41
    mov rdx, 0777
    mov rax, 2
    syscall
    mov r12, rax

    # 6. Write Body
    mov rdi, r12        # File descriptor
    mov rsi, r10        # Body start address (RELOADED)
    mov rdx, r13        # Total bytes
    mov rax, rsi        # Calculate header length
    sub rax, rsp
    sub rdx, rax        # Body length = Total - header
    mov rax, 1
    syscall

    # 7. Close file
    mov rdi, r12
    mov rax, 3
    syscall

    # 8. Send HTTP Response
    mov rdi, r14
    lea rsi, [rip + header]
    mov rdx, 19
    mov rax, 1
    syscall

    # 9. EXIT CHILD (CRITICAL)
    mov rdi, 0
    mov rax, 60
    syscall

.parent_process:
    # Close connection and loop for next client
    mov rdi, r14
    mov rax, 3
    syscall
    jmp .request_loop
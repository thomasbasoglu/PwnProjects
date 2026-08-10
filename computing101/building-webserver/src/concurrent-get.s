.intel_syntax noprefix
.global _start

.section .data
header: .ascii "HTTP/1.0 200 OK\r\n\r\n"

.section .text
_start:
    # Socket
    mov rdi, 2
    mov rsi, 1
    xor rdx, rdx
    mov rax, 41
    syscall
    mov r15, rax

    # Bind
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

    # Listen
    mov rdi, r15
    xor rsi, rsi
    mov rax, 50
    syscall

.loop_start:
    # Accept
    mov rdi, r15
    xor rsi, rsi
    xor rdx, rdx
    mov rax, 43
    syscall
    mov r14, rax

    # Fork
    mov rax, 57
    syscall
    test rax, rax
    jz .child_process

    # Parent Process
    mov rdi, r14
    mov rax, 3
    syscall
    jmp .loop_start

.child_process:
    # Close Listen Socket
    mov rdi, r15
    mov rax, 3
    syscall

    # Read Request
    sub rsp, 0x400
    mov rdi, r14
    mov rsi, rsp
    mov rdx, 0x400
    xor rax, rax
    syscall

    # Parse Filename 
    lea rdi, [rsp+4] 
    xor rax, rax
.find_space:
    cmpb [rdi+rax], 0x20
    je .found
    inc rax
    jmp .find_space
.found:
    movb [rdi+rax], 0x0

    # Open and Read File
    lea rdi, [rsp+4]
    mov rsi, 0
    mov rax, 2
    syscall
    mov rdi, rax
    sub rsp, 0x1000
    mov rsi, rsp
    mov rdx, 0x1000
    xor rax, rax
    syscall
    mov r13, rax
    mov rax, 3
    syscall

    # Send Header (Using .data section)
    mov rdi, r14
    lea rsi, [rip + header]
    mov rdx, 19
    mov rax, 1
    syscall

    # Send Content
    mov rdi, r14
    lea rsi, [rsp]
    mov rdx, r13
    mov rax, 1
    syscall

    # Close and Cleanup
    mov rdi, r14
    mov rax, 3
    syscall
    
    # Exit Child
    mov rdi, 0
    mov rax, 60
    syscall
    
.intel_syntax noprefix
.global _start

.section .text

_start:
    # First I open the file 
    mov rdi, [rsp+16]   # Loaded pointer to rsp+16
    mov rsi, 0          # Specified the default read access of the second argument
    mov rax, 2          # sys_open with siscall 2
    syscall

    # Second we read 64 bytes into the memory
    mov rdi, rax        # Moving file descriptor to rdi
    mov rax, 0          # sys_read where read is 0
    mov rsi,rsp         # Using stack as buffer
    mov rdx, 64         # Reading 64 bytes into buffer
    syscall

    # Writing to std_out
    mov rdx, rax        # Use the same number of bytes to read
    mov rax, 1          # sys_write which is equal to 1
    mov rdi, 1          # std_out which has the value of 1
    mov rsi, rsp        # Buffer is still the stack
    syscall

    mov rax, 60
    mov rdi, 42
    syscall
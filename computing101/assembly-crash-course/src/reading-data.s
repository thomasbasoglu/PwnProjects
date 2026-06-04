.intel_syntax noprefix
.global _start

.section .text

_start:
    # First READ 64 bytes from stdin (fd 0) into the stack
    mov rax, 0          # syscall: read
    mov rdi, 0          # file descriptor: stdin
    mov rsi, rsp        # buffer: top of the stack
    mov rdx, 64         # count: 64 bytes
    syscall

    # Then WRITE 64 bytes from the stack to stdout (fd 1)
    mov rax, 1          # syscall: write
    mov rdi, 1          # file descriptor: stdout
    mov rsi, rsp        # buffer: top of the stack (where we just read data)
    mov rdx, 64         # count: 64 bytes
    syscall

    # 3. EXIT with code 42
    mov rax, 60         # syscall: exit
    mov rdi, 42         # exit status: 42
    syscall
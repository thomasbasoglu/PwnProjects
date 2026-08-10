.intel_syntax noprefix
.global _start

.section .text 

_start:
    # Creating socket 
    mov rax, 41     # syscall for socket
    mov rdi, 2      # family AF_INET
    mov rsi, 1      # type is SOCK_STREAM
    mov rdx, 0      # protocol IPPROTO_IP
    syscall

    # 2. Save the socket FD
    mov rdi, rax    # rdi = 3 (first arg for bind)

    xor rax, rax 
    push rax
    # Push next 8 bytes: IP (4 bytes of 0), Port (0x5000), Family (0x0002)
    # (Note: 0x5000 is Port 80 in Big-Endian)
    mov rsi, 0x0000000050000002
    push rsi
    
    # Bind Socket
    mov rax, 49     # syscall for bind 
    mov rsi, rsp    #  the IP address on the stack 
    mov rdx, 16     # Size of the  sock address 
    syscall

    # The glamorous exit
    mov rax, 60     # exits
    xor rdi, rdi    # reset the rdi
    syscall
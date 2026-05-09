.intel_syntax noprefix
.global _start
.section .data 
    
    message: 
        .ascii "HTTP/1.0 200 OK"
        .byte 0x0d, 0x0a, 0x0d, 0x0a
.section .text 

_start:
    # Creating socket 
    mov rax, 41     # syscall for socket
    mov rdi, 2      # family AF_INET
    mov rsi, 1      # type is SOCK_STREAM
    mov rdx, 0      # protocol IPPROTO_IP
    syscall

    # Build sockaddr_in on the stack & Bind
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

    # Listening
    mov rax, 50     # Value of listen 
    mov rdi, 3      # file desc 
    xor rsi, rsi    # backlog let 0 conn wait in queue (expected in tests)
    syscall

    # Accepting conn now from host 
    mov rax, 43     # syscall value for accept 
    mov rdi, 3      # the listening socket file desc
    xor rsi, rsi    # pointer to a struct to store client IP
    xor rdx,rdx     # Pointer to the sie of that struct
    syscall 

    # Save client file descriptor 
    mov rdi, rax    # Getting the connecting value from accepting
    
    # Read the request
    xor rax, rax    # syscall 0 read
    mov rsi, rsp    # Using the stack as memory bin 
    mov rdx, 1024   # Read up to 1024 bytes
    syscall

    # Sending a static response  
    mov rax,1       # syscall value for write
    lea rsi, [rip + message]
    mov rdx, 19
    syscall

    # Closing the socket
    mov rax, 3  # syscall 3 close 
    syscall

    # The glamorous exit
    mov rax, 60     # exits
    xor rdi, rdi    # reset the rdi
    syscall
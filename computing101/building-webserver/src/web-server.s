.intel_syntax noprefix
.global _start
.section .data
header: .ascii "HTTP/1.0 200 OK\r\n\r\n"
.section .text
_start:
    mov rdi, 2
    mov rsi, 1
    xor rdx, rdx
    mov rax, 41
    syscall
    mov r15, rax

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

    mov rdi, r15
    xor rsi, rsi
    mov rax, 50
    syscall

.request_loop:
    mov rdi, r15
    xor rsi, rsi
    xor rdx, rdx
    mov rax, 43
    syscall
    mov r14, rax

    mov rax, 57
    syscall
    test rax, rax
    jnz .parent_process

.child_process:
    mov rdi, r15
    mov rax, 3
    syscall

    sub rsp, 0x1000
    mov rdi, r14
    mov rsi, rsp
    mov rdx, 0x1000
    xor rax, rax
    syscall
    mov r13, rax        # total bytes read

    cmpb [rsp], 0x47    # 'G'
    je .handle_get
    jmp .handle_post

.handle_get:
    # Path starts at rsp+4 ("GET /path ")
    lea rdi, [rsp+4]
    xor rax, rax
.get_path_len:
    cmpb [rdi+rax], 0x20
    je .get_path_done
    inc rax
    jmp .get_path_len
.get_path_done:
    movb [rdi+rax], 0x0

    # open(path, O_RDONLY)
    lea rdi, [rsp+4]
    xor rsi, rsi        # O_RDONLY = 0
    xor rdx, rdx
    mov rax, 2
    syscall
    mov r12, rax        # file fd

    # read file into a second buffer on stack
    sub rsp, 0x1000
    mov rdi, r12
    mov rsi, rsp
    mov rdx, 0x1000
    xor rax, rax
    syscall
    mov r10, rax        # bytes read from file

    # close file
    mov rdi, r12
    mov rax, 3
    syscall

    # send HTTP header
    mov rdi, r14
    lea rsi, [rip + header]
    mov rdx, 19
    mov rax, 1
    syscall

    # send file content
    mov rdi, r14
    mov rsi, rsp
    mov rdx, r10
    mov rax, 1
    syscall

    add rsp, 0x1000
    jmp .exit_child

.handle_post:
    # Path starts at rsp+5 ("POST /path ")
    lea rdi, [rsp+5]
    xor rax, rax
.post_path_len:
    cmpb [rdi+rax], 0x20
    je .post_path_done
    inc rax
    jmp .post_path_len
.post_path_done:
    movb [rdi+rax], 0x0

    # Find \r\n\r\n body separator
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
    mov r10, rsi        # body start

    # open(path, O_WRONLY|O_CREAT, 0777)
    lea rdi, [rsp+5]
    mov rsi, 0x41
    mov rdx, 0777
    mov rax, 2
    syscall
    mov r12, rax

    # write body
    mov rdi, r12
    mov rsi, r10
    mov rdx, r13
    mov rax, rsi
    sub rax, rsp
    sub rdx, rax
    mov rax, 1
    syscall

    # close file
    mov rdi, r12
    mov rax, 3
    syscall

    # send HTTP header
    mov rdi, r14
    lea rsi, [rip + header]
    mov rdx, 19
    mov rax, 1
    syscall

.exit_child:
    mov rdi, 0
    mov rax, 60
    syscall

.parent_process:
    mov rdi, r14
    mov rax, 3
    syscall
    jmp .request_loop
    
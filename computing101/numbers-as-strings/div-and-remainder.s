.intel_syntax noprefix
.global itoa

itoa:
    # 1. Prepare for division
    mov rax, rdi
    xor rdx, rdx
    mov rcx, 10
    div rcx
    # rax = tens, rdx = ones

    # 2. Convert and store tens
    add rax, 0x30
    mov [rsi], al

    # 3. Convert and store ones
    add rdx, 0x30
    mov [rsi + 1], dl

    # 4. Return 2
    mov rax, 2
    ret


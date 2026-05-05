.intel_syntax noprefix
.global _start

.section .text 

_start:
    # Comparing rdi address 
    cmp dword ptr [rdi], 0x7f454c46
    je is_equal
    cmp dword ptr [rdi], 0x00005A4D
    je is_equal2
    jmp else

is_equal:
    # y = [x+4] + [x+8] + [x+12]
    # First add the values 
    movsx rax, dword ptr [rdi + 4]
    movsx rbx, dword ptr [rdi + 8]
    movsx rsi, dword ptr [rdi + 12]

    # Second add the values together
    add rax, rbx
    add rax, rsi 
    jmp finish

is_equal2:
    # y = [x+4] - [x+8] - [x+12]
    # First add the values 
    movsx rax, dword ptr [rdi + 4]
    movsx rbx, dword ptr [rdi + 8]
    movsx rsi, dword ptr [rdi + 12]

    # Second subt the values 
    sub rax, rbx
    sub rax, rsi 
    jmp finish

else:
    # y = [x+4] * [x+8] * [x+12]
    # First add the values 
    movsx rax, dword ptr [rdi + 4]
    movsx rbx, dword ptr [rdi + 8]
    movsx rsi, dword ptr [rdi + 12]

    # Second mult the values 
    imul rax, rbx
    imul rax, rsi 

finish:
    # 32 bit finish
    mov eax, eax
    

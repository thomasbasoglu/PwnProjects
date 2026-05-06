.intel_syntax noprefix

.global _start

.section .text

_start:
    
    xor rax, rax    # 0 the rax
    test rdi, rdi   # checking carry flag
    jz exit         # Jump to the glammorous exitt

loop_start:
    
    mov cl,[rdi]    # Loading current byte to cl 
    test cl, cl     # checking carry flag
    jz exit         # Jump to the glammorous exitt

    inc rax 
    inc rdi 
    jmp loop_start  # Jump back in

exit:


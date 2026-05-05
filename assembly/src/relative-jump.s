.intel_syntax noprefix
.global _start

.section .text 

_start:
    # performing a jump of 0x51 bytes
    jmp destination
    
    # No operations 
    .rept 0x51
        nop 
    .endr # ending the rept 

destination:
    # Setting rax
    mov rax, 0x1

    
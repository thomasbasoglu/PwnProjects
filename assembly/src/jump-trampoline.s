.intel_syntax noprefix
.global _start

.section .text 

_start:
    jmp destination

    # jmping to the trampoline on 0x51
    .rept 0x51
        nop 
    .endr # ending the rept 


destination:
    # Place the top stack into rdi 
    pop rdi 

    # using a an absolute jump trampoline weeee
    mov rax, 0x403000
    jmp rax 

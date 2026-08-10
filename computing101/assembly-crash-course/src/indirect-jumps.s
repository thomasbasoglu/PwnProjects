.intel_syntax noprefix
.global _start

.section .text 

_start:
    cmp rdi, 3
    ja func

    jmp [rsi + rdi *8]

func:
    jmp [rsi + 32] 

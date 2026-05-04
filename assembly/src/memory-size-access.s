.intel_syntax noprefix
.global _start
.section .text
_start:
    movzx rax, byte ptr [0x404000] # Set rax to the byte
    movzx rbx, word ptr [0x404000] # Set rbx to the word
    mov ecx, [0x404000]            # Set rcx to the double word
    mov rdx, [0x404000]            # Set rdx to the quad word
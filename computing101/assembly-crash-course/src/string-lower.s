.intel_syntax noprefix
.global _start

_start:
    push rbx              
    push r12              

    xor r12, r12          
    mov rbx, rdi          

    test rbx, rbx         
    jz cleanup            

loop_start:
    movzx rdi, byte ptr [rbx] 
    test dil, dil
    jz cleanup           

    cmp dil, 0x5a
    ja next_char          
   
    mov rax, 0x403000
    call rax              

    mov [rbx], al
    inc r12               
next_char:
    inc rbx               
    jmp loop_start

cleanup:
    mov rax, r12          
    pop r12               
    pop rbx               
    ret                  
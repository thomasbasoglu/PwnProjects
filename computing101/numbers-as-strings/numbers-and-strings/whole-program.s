.intel_syntax noprefix 
.global _start 

_start:
  # Get pointer argv[1]
  mov rsi, [rsp + 16]

  # Convert string to int 
  xor rax, rax
  xor rcx, rcx

atoi_loop:
    mov cl, [rsi]         # Load current character
    cmp cl, 0             # Check for null terminator
    je exit       
    
    sub cl, '0'           # Convert ASCII to integer 
    imul rax, 10          # Multiply total by 10
    add rax, rcx          # Add new digit
    inc rsi               
    jmp atoi_loop 

exit:
  # The glamorous exit
  mov rdi, rax 
  mov rax, 60
  syscall

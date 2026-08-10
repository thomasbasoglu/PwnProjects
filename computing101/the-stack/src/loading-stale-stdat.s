.intel_syntax noprefix 
.global solve

solve:
  # Preserve stack frame 
  push rbp
  mov rbp, rsp

  # The func pointer to load_secret in rdi 
  call rdi 

  # Load the stale 8 byte value to rax 
  mov rax, qword ptr [rsp - 0x10]
  pop rbp
  ret

.intel_syntax noprefix
.global solve

solve:
  # Reserve 256 bytes of stack space
  sub rsp, 256

  # Clear the memory rcx is the counter
  mov rcx, 255

clear_loop:
  mov byte ptr [rsp + rcx], 0
  dec rcx
  jns clear_loop   

  # Restore stack pointer 
  add rsp, 256

  ret


.intel_syntax noprefix
.global itoa_digit

itoa_digit:
  # Take the value in rdi add 0x30 to get ascii
  mov rax, rdi
  add rax, 0x30

  ret

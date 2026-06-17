.intel_syntax noprefix
.global atoi_digit

atoi_digit:
	movzx rax, byte ptr [rdi]
	sub rax, 0x30
	ret
	
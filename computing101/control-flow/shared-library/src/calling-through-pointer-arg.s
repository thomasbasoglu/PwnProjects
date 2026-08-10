.intel_syntax noprefix
.global solve

solve:
	# Storing the value and overwriting register
	mov rax, rdi
	mov rdi, 1337
	call rax
	ret
.intel_syntax noprefix
.global solve

solve:
	# Moving the value from rdi to rax
	mov rax, rdi

	# Returning to caller
	ret
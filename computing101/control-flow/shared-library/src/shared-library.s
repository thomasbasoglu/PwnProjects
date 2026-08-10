.intel_syntax noprefix
.global solve

solve:
	# Prepare for write
	mov rdx, rsi
	mov rsi, rdi
	mov rdi, 1
	mov rax, 1
	syscall


	# The glamorous exit
	xor rdi, rdi
	mov rax, 60
	syscall
.intel_syntax noprefix
.global solve 

solve:
	# Load the address into rsi
	lea rsi, [rsp + 0x40]

	# Setup write syscall
	mov rax, 1
	mov rdi, 1
	mov rdx, 64		# length of bytes to print
	syscall

	# Returning to the caller
	ret 

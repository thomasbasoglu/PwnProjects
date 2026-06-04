.intel_syntax noprefix
.global solve
.type solve, @function

solve:
	
	# Reach into the stack to find environment variable
	mov rsi, [rsp + 24]

	# Setting up write syscall
	mov rax, 1
	mov rdi, 1
	mov rdx, 128
	syscall 

	mov rax, 60
	mov rdi, 0
	syscall
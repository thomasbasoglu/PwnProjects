.intel_syntax noprefix
.global atoi
.global atoi_digit

atoi_digit:
	movzx rax, byte ptr [rdi]
	sub rax, 0x30
	ret

atoi:
	# Save data to stack 
	push rbx
	push rdi

	# First digit
	call atoi_digit

	# Multiply 10s digit 10
	imul rax, 10
	mov rbx, rax 

	pop rdi 
	inc rdi 

	call atoi_digit

	# Add the ones and tens 
	add rax, rbx

	pop rbx 
	ret


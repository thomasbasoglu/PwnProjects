.intel_syntax noprefix
.global atoi

atoi:
	# Result total and r8 is negative flag 0 false and 1 true and rcx is multiplier
	xor rax, rax
	xor r8, r8
	mov rcx, 10

	# Check negative sign 
	mov dl, byte ptr [rdi]
	cmp dl, 0x2d	# Ascii for -
	jne loop_start

	# If it is negative set the flag and move pointer
	mov r8, 1
	inc rdi

loop_start:
	movzx rdx, byte ptr [rdi]	# Fetch the character
	test rdx, rdx	# Check for null
	jz loop_end

	sub rdx, 0x30	# Convert ascii to int
	push rdx

	# Standard conversion we did before
	mul rcx
	pop rdx
	add rax, rdx

	inc rdi 
	jmp loop_start

loop_end:
	test r8, r8
	jz done 
	neg rax 

done:
	ret

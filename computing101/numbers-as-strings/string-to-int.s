.intel_syntax noprefix
.global atoi
.global _start

_start:
    push 0x333231   # "123" on the stack -- little-endian, so 0x31 ('1') is the first byte, and the high zero bytes terminate it
    mov rdi, rsp    # a pointer to that string, as the first argument to atoi
    int3            # this is optional, if you want gdb to break here without having to set a breakpoint!
    call atoi       # there we go!

    mov rdi, rax    # atoi s result comes back in rax; exit with it so you can read it back with `echo $?`
    mov rax, 60     # exit
    syscall

atoi:
	# Clear rax and load 10 rcx for multiplication
	xor rax, rax 
	mov rcx, 10

loop_start:
	# Move the next byte to rdx and check if null
	movzx rdx, byte ptr [rdi]
	test rdx, rdx
	jz loop_end

	# Prep for total times ten plus digit
	push rdx 
	mul rcx 
	pop rdx 

	# Converting ascii to int (subtract 0x30 from digit)
	sub rdx, 0x30

	# Add digit to total 
	add rax, rdx

	# Move to the next character in the string 
	inc rdi 
	jmp loop_start


loop_end:
	ret


from pwn import *

# This is the binary path 
target = '/challenge/runme'

# Defining the raw bytes within the script when you 
# cat the target meow
correct_password = b"\x9e\x94\xe0\xb8\x8d\x84\xa2\x8b"

bit_string = "".join(f"{b:08b}" for b in correct_password)

# Print it out so we can see it
print(f"Sending bits: {bit_string}")

# Starting the process 
p = process(target)

# Wait for the prompt
p.recvuntil(b"Enter the password:")

# Send the raw string of 1s and 0s
p.send(bit_string.encode())

# Read everything until the end
print(p.recvall().decode())
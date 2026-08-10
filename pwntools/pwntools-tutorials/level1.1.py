from pwn import *

# Starting the buffer 
part1 = b"p" + b"\x15"

# Integer 
part2 = p32(123456789)

# The string 
part3 = b"Bypass Me:)"

payload = part1 + part2 + part3

p = process("/challenge/pwntools-tutorials-level1.1")
p.sendline(payload)
print(p.recvall().decode())


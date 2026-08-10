from pwn import *

# Architecture 
context(arch = "amd64", os = "linux", log_level = "info")

path = "/challenge/pwntools-tutorials-level1.0"

p = process(path)

payload = p32(0xdeadbeef)

p.sendline(payload)

print(p.recvall().decode())

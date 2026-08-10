from pwn import *

# Set architecture, os and log level
context(arch="amd64", os="linux", log_level="info")

# Load the ELF file and execute it as a new process 
challenge_path = "/challenge/pwntools-tutorials-level0.0"
p = process(challenge_path)

payload = b"pokemon"

# Send the payload
p.sendline(payload)

# Recieve flag from the process 
flag = p.recvall()
print(f"flag is: {flag.decode()}")

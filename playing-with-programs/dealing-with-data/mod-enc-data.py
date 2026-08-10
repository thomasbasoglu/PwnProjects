from pwn import *

# This is the password stated in the file 
password = b"\xf1~\xe6P\xc0\x9a\x1f\xa6"

# Converting bytes to hex string 
hex_string = password.hex()

# Reverse the string since the challenge reversed it 
payload = hex_string[::-1]

log.info(f"Sending reversed hex: {payload}")

# Start process 
p = process("/challenge/runme")

# wait prompt to send  
p.recvuntil(b"Enter the password:\n")
p.sendline(payload.encode())

# Get the flag 
print(p.recvall().decode())
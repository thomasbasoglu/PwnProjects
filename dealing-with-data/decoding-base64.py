from pwn import *

# This is the password stated in the file 
password = "tr+9lomCXsc="

payload = b64d(password)
log.info(f"Stored String: {password}")
log.info(f"Actual Bytes expected by program: {payload}")

# Start process 
p = process("/challenge/runme")

# Wait for prompt
p.recvuntil(b"Enter the password:\n")

# send payload 
p.send(payload)

# Get the flag 
print(p.recvall().decode())
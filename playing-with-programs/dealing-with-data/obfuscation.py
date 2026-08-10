from pwn import *

# the password 
password = b"\x9c\xebn\xb4\xd1\xe5r\x05"

# step 1 and 2 hex it then base64
step1_str = enhex(password)

step2_str = b64e(step1_str.encode())

# reverse now
step3_str = step2_str[::-1]

# Final hex
payload = enhex(step3_str.encode()).encode()
log.info(f"Final Payload: {payload}")

p = process("/challenge/runme")
p.recvuntil(b"Enter the password:\n")
p.send(payload)

print(p.recvall().decode())
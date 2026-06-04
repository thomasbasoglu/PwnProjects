from pwn import *

password = b"\xbe\xe2\r\xf0\xcb\xc2y\xec"

# Programs target 
step1 = password[::-1]
step2 = b64e(step1).encode()
step3 = b64e(step2).encode()
step4 = step3[::-1]

log.info(f"The program's internal target bytes: {step4}")

# Input and payload
val = step4[::-1]
val = b64e(val).encode()
val_hex_once = enhex(val).encode()
payload = enhex(val_hex_once).encode()

log.info(f"Final Double-Hex Payload: {payload}")

p = process("/challenge/runme")
p.recvuntil(b"Enter the password:\n")
p.send(payload)
print(p.recvall().decode())



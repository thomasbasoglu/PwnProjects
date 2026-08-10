from pwn import * 

# Found the password in the file yipie yippie yay
password = b"ycwzkrqj"

# Connvert the characters to hex strings 
hex_string = password.hex()

# It needs a file so lets write it out 
file_path = "/tmp/pass_bits"
with open(file_path,"wb") as f:
    f.write(hex_string.encode('ascii'))

log.info(f"Wrote {len(hex_string)} bytes to {file_path}")

# Connecting to the challenge 
p = process(['/challenge/runme', file_path])

# Print the flag
print(p.recvall().decode())
from pwn import * 

# Found the password in the file yipie yippie yay
password = b"hnupggrr"

# Connvert the characters to hex strings cause it wants four times 

payload = password
for i in range(4):
    hex_representation = payload.hex()

    # Turn the string back into bytes so next loop can hex it 
    payload = hex_representation.encode('ascii')

    print(f"Layer {i+1} length {len(payload)} bytes")

# It needs a file so lets write it out 
file_path = "/tmp/pass_bits"
with open(file_path,"wb") as f:
    f.write(payload)

log.info(f"Wrote {len(payload)} bytes to {file_path}")

# Connecting to the challenge 
p = process(['/challenge/runme', file_path])

# Print the flag
print(p.recvall().decode())
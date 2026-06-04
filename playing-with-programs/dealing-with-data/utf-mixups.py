from pwn import * 

# Found the password in the file yipie yippie yay
password = "qxxxucwq"

# It needs a file so lets write it out  and encode utf 16
file_path = "deba"
with open(file_path,"wb") as f:
    f.write(password.encode('utf-16le'))

log.info(f"Wrote UTF-16 payload to {file_path}")

# Connecting to the challenge 
p = process('/challenge/runme')

# Print the flag
print(p.recvall().decode())
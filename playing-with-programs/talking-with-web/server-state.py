import requests

# Create a session object. 
# This automatically handles storing and sending cookies across requests.
session = requests.Session()

# The server requires 4 requests to reach the 'state' goal.
url = "http://127.0.0.1/"

for i in range(1, 5):
    # Perform the GET request. 
    
    response = session.get(url)
    
    print(f"Request {i} status: {response.status_code}")
    
print("\nFinal Result:")
print(response.text)

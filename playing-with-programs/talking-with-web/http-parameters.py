import requests

# Target URL and the parameters 
url = "http://challenge.localhost:80/complete"
params = {"authcode": "lxoiofop"} 

try:
    # Send get request
    response = requests.get(url, params=params)

    # Print result 
    print(f"Status Code: {response.status_code}")
    print("\nResponse Body:")
    print(response.text)

except Exception as e:
    print(f"An error occured: {e}")
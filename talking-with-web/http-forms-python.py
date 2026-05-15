import requests

url = "http://challenge.localhost:80/hack"

payload = {
    "keycode": "fmtmyxng"
}

try:
    # Send the POST request with both the headers and form data
    response = requests.post(url, data=payload)
    
    print(f"Status Code: {response.status_code}")
    print("\nResponse Body:")
    print(response.text)

except Exception as e:
    print(f"An error occurred: {e}")
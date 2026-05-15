import requests

url = "http://challenge.localhost:80/gate"

custom_headers = {
    "User-Agent": "Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/115.0"
}

payload = {
    "keycode": "fmtmyxng"
}

try:
    # Send the POST request with both the headers and form data
    response = requests.post(url, headers=custom_headers, data=payload)
    
    print(f"Status Code: {response.status_code}")
    print("\nResponse Body:")
    print(response.text)

except Exception as e:
    print(f"An error occurred: {e}")
import requests
url = "http://127.0.0.1/challenge"
headers = {"Host": "alf.nu"}

try:
    response = requests.get(url, headers=headers)
    print(f"Status Code: {response.status_code}")
    print("\nResponse body: ")
    print(response.text)

except Exception as e:
    print(f"Connnectoion failed: {e}")

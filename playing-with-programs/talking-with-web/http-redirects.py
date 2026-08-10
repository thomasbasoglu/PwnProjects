
import requests
url = "http://challenge.localhost"
response = requests.get(url)

print(response.status_code)
print(response.text)





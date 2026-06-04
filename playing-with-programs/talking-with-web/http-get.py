
import requests
url = "http://challenge.localhost/qualify"
response = requests.get(url)

print(response.status_code)
print(response.text)





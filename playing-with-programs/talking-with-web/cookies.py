import requests

session = requests.Session()

response1 = session.get("http://challenge.localhost/")

if response1.history:
	print(f"Redirected from: {response1.history[0].url}")
	print(f"Final URL: {response1.url}")

final_response = session.get(response1.url)
print(final_response.text)
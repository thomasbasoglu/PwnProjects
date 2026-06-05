from http.server import HTTPServer, BaseHTTPRequestHandler

class RedirectHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(302)
        # Point them to the correct path
        self.send_header('Location', 'http://challenge.localhost:80/request')
        self.end_headers()
        print("Redirecting client to http://challenge.localhost:80/request")

class ReusableHTTPServer(HTTPServer):
    allow_reuse_address = True

if __name__ == "__main__":
    httpd = ReusableHTTPServer(('0.0.0.0', 1337), RedirectHandler)
    print("Redirector listening on 0.0.0.0:1337...")
    httpd.serve_forever()

from http.server import HTTPServer, BaseHTTPRequestHandler

class FlagHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        print(f"DEBUG: Received request on {self.path}")
        self.send_response(200)
        self.end_headers()
        self.wfile.write(b"ACK")

class ReusableHTTPServer(HTTPServer):
    allow_reuse_address = True

# Bind to 0.0.0.0 to ensure the client can reach you regardless of interface
httpd = ReusableHTTPServer(('0.0.0.0', 1337), FlagHandler)
print("Server listening on 0.0.0.0:1337...")
httpd.serve_forever()

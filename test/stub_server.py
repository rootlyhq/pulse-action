"""Minimal stand-in for the Rootly pulses API, used by CI.

Writes each request body to the file given as argv[1] and replies with a
canned pulse so the action can run end to end without real credentials.
"""
import http.server
import sys

BODY_FILE = sys.argv[1]
PORT = int(sys.argv[2]) if len(sys.argv) > 2 else 8765


class Handler(http.server.BaseHTTPRequestHandler):
    def do_POST(self):
        length = int(self.headers.get("Content-Length", 0))
        with open(BODY_FILE, "wb") as f:
            f.write(self.rfile.read(length))
        self.send_response(201)
        self.send_header("Content-Type", "application/vnd.api+json")
        self.end_headers()
        self.wfile.write(b'{"data":{"id":"pulse-123","type":"pulses","attributes":{}}}')


http.server.HTTPServer(("127.0.0.1", PORT), Handler).serve_forever()

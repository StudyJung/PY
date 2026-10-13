import http.server
import socketserver

PORT = 8888

handler = http.server.SimpleHTTPRequestHandler
with socketserver.TCPServer(("127.0.0.1", PORT), handler) as httpd:
    print(f"Running on http://localhost:{PORT}")
    httpd.serve_forever()

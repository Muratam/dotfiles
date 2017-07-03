from  http.server import HTTPServer,SimpleHTTPRequestHandler


class HTTPHandler72(SimpleHTTPRequestHandler):
    
    def parse_url_params(self):
        import urllib.parse
        params = urllib.parse.parse_qs(urllib.parse.urlparse(self.path).query)
        params = {k:v[0] for k,v in params.items()}
        return params

    def do_GET(self):
        body = self.get_action(self.parse_url_params()).encode("utf-8")
        self.send_response(200)
        self.send_header("Content-type", "text/plain;charset=utf-8")
        self.send_header("Content-length",len(body))
        self.end_headers()
        self.wfile.write(body)

    def get_action(self,params):
        print(params)
        return "いっと☆ わーくす"

def serve_forever(host="localhost",port=7272,handler=HTTPHandler72):
    print("server start {}:{} ({})".format(host,port,handler))
    HTTPServer((host,port),handler).serve_forever()


if __name__ == '__main__': 
    print("Usage :: serve_forever('localhost',7272,HTTPHandler72)")
    serve_forever()

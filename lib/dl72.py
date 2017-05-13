from bs4 import BeautifulSoup
import requests
import os
import shutil


class DL72:

    def __init__(self, url):
        self.url = url
        self.got = requests.get(url)
        self.html = self.got.text
        self.soup = BeautifulSoup(self.html, "html5lib")

    def _make_local_path(url, dirname, local_prefix):
        if not dirname:
            return os.path.basename(url)
        if not dirname.endswith("/"):
            dirname += "/"
        if not os.path.exists(dirname):
            os.mkdir(dirname)
        return dirname + str(local_prefix) + os.path.basename(url)

    def download(url, dirname="", local_prefix="", binary=True):
        local_path = DL72._make_local_path(url, dirname, local_prefix)
        if binary:
            with open(local_path, "wb") as f:
                shutil.copyfileobj(requests.get(url, stream=True).raw, f)
        else:
            with open(local_path, "w") as f:
                f.write(requests.get(url).text)

if __name__ == "__main__":
    print("""Usage :
    soup = DL72("http://example.com").soup
    for a in soup.select("a"):
        if a.text.startswith("aaa"):
            print(a)
    DL72.download("http://example.com/hoge.jpg","hoge",0)""")

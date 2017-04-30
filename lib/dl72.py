from bs4 import BeautifulSoup
import requests
import os
import shutil
from pprint import pprint
import re


class DL72:

    def __init__(self, url):
        self.url = url
        self.got = requests.get(url)
        self.html = self.got.text
        self.soup = BeautifulSoup(self.html, "html5lib")

    def _make_local_path(url, dirname):
        if not dirname:
            return os.path.basename(url)
        if not dirname.endswith("/"):
            dirname += "/"
        if not os.path.exists(dirname):
            os.mkdir(dirname)
        return dirname + os.path.basename(url)

    def dl_binary(url, dirname=""):
        local_path = DL72._make_local_path(url, dirname)
        with open(local_path, "wb") as f:
            shutil.copyfileobj(requests.get(url, stream=True).raw, f)

    def dl(url, dirname=""):
        local_path = DL72._make_local_path(url, dirname)
        with open(local_path, "w") as f:
            f.write(requests.get(url).text)

if __name__ == "__main__":
    basepath = "http://people.cs.ubc.ca/~murphyk/MLbook/figReport-16-Aug-2012/"
    soup = DL72(basepath + "pmlFigureCodeTable.html").soup
    pdfs = []
    for tr in soup.select("tr"):
        tds = tr.select("td")
        if len(tds) <= 2:
            continue
        if not tds[0].text.startswith("8"):
            continue
        for a in tds[1].select("a"):
            pdfs.append(a.get("href"))
    for pdf in pdfs:
        print(pdf)
        DL72.dl_binary(basepath + pdf, "mlapp")

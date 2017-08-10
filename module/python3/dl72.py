from bs4 import BeautifulSoup
import requests
import os
import shutil
import re
from pprint import pprint
from urllib.parse import urljoin


class DL72:

    def __init__(self, url):
        self.url = url
        self.got = requests.get(url)
        if self.got.encoding.startswith("ISO"):
            self.got.encoding = self.got.apparent_encoding
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

    def download(url, dirname="", local_prefix="", binary=True, force_name=""):
        "download (binary)file to directory"
        local_path = DL72._make_local_path(url, dirname, local_prefix)
        if force_name:
            local_path = force_name
        if binary:
            with open(local_path, "wb") as f:
                shutil.copyfileobj(requests.get(url, stream=True).raw, f)
        else:
            with open(local_path, "w") as f:
                f.write(requests.get(url).text)

    def get_links(self, href_pattern=r'.*', text_pattern=r'.*'):
        founds = self.soup.find_all('a', text=re.compile(text_pattern))
        res = []
        for found in founds:
            href = urljoin(self.url, found.get("href"))
            if not re.match(href_pattern, href):
                continue
            res.append({
                "text": found.text,
                "href": href})
        return res

    def scan_table(self, verpose=False, ignore_th=False):
        tables = []
        for i_table in self.soup.select("table"):
            table = []
            for i_tr in i_table.select("tr"):
                tr = []
                for i_td in i_tr.select("td" if ignore_th else "th,td"):
                    if verpose:
                        td = {"class": i_td.get("class"), "text": i_td.text}
                    else:
                        td = i_td.text
                    tr.append(td)
                if tr:
                    table.append(tr)
            if table:
                tables.append(table)
        return tables


if __name__ == "__main__":
    print("""Usage :
    soup = DL72("http://example.com").soup
    for a in soup.select("a"):
        if a.text.startswith("aaa"):
            print(a)
    DL72.download("http://example.com/hoge.jpg","hoge",0)""")

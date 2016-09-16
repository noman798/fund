from config import CONFIG
import requests
from f42.extract import extract, extract_all
import demjson
from html import unescape
from db.wx import post_save


def fetch_wx(url):
    o = requests.get(url + "&f=json").json()
    title = o['title']
    desc = o['desc']
    html = o['content']
    nick_name = o['nick_name']
    alias = o.get('alias', '')
    author = o.get('author')
    src = o.get('source_url')
    url = o.get('link')
    post_save(url, src, title, desc, html, author, nick_name, alias)


def fetch_qq_space(qq):
    r = requests.get(
        """http://ic2.s21.qzone.qq.com/cgi-bin/feeds/feeds_html_act_all?hostuin=%s""" % qq
    ).content.decode('utf-8')
    data = extract('"data":', None, r)[:-3].strip()[:-1]
    data = demjson.decode(data)
    data = data['friend_data']

    for i in data:
        if i and 'html' in i:
            for url in extract_all('href="', '"', i['html']):
                if url.startswith("http://mp.weixin.qq.com/"):
                    fetch_wx(unescape(url).rsplit("#", 1)[0])
                    break


if __name__ == "__main__":
    fetch_qq_space(CONFIG.QQ.ID)

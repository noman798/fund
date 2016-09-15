from config import CONFIG
import requests
from f42.extract import extract, extract_all
import demjson


def fetch_wx(url):
    print(url)


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
                    fetch_wx(url)
                    break


if __name__ == "__main__":
    fetch_qq_space(CONFIG.QQ.ID)

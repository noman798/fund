import requests
from ztz.util.extract import extract, extract_all
import demjson
from html import unescape
from db.wx import post_save
from db.qq import qq_save
from db.wx_xueqiu import wx_xueqiu_post_save, wx_xueqiu_sync
import traceback


def fetch_wx(url):
    o = requests.get(url + "&f=json").json()
    print(o)
    title = o['title']
    desc = o['desc']
    html = o['content']
    nick_name = o['nick_name']
    alias = o.get('alias', '')
    author = o.get('author')
    src = o.get('source_url')
    url = o.get('link')
    create_time = o.get('ori_create_time')
    return post_save(url, src, title, desc, html, author,
                     nick_name, alias, create_time)


def fetch_qq_space(qq):
    user_id = qq_save(qq)
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
                    try:
                        post_id = fetch_wx(unescape(url).rsplit("#", 1)[0])
                        wx_xueqiu_post_save(user_id, post_id)
                    except:
                        traceback.print_exc()
                    break


if __name__ == "__main__":
    fetch_qq_space(375956667)
    wx_xueqiu_sync()

from ztz.redis.sync.cid import gid
from __init__ import Q
from urllib.parse import urlparse, parse_qsl


def post_save(url, src, title, desc, html, author, wx_name, wx_alias):
    print(title)
    print(desc)
    # print(html)
    print(author)
    print(src)
    url = urlparse(url)
    url = dict(parse_qsl(url.query))
    print(url)
    _biz = url['__biz']
    biz = Q.WxBiz.get(biz=_biz)
    if biz:
        wx_id = biz._id
    else:
        wx_id = gid()
        Q.WxBiz.save(
            _id=wx_id,
            biz=_biz,
            wx_name=wx_name,
            wx_alias=wx_alias
        )
        print(wx_id)

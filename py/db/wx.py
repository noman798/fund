from ztz.redis.sync.cid import gid
from db import Q
from urllib.parse import urlparse, parse_qsl
from base64 import b64decode


def post_save(url, src, title, desc, html, author, wx_name, wx_alias):
    url = urlparse(url)
    url = dict(parse_qsl(url.query))
    _biz = url['__biz']
    biz = Q.Wx.get(biz=_biz)
    if biz:
        wx_id = biz._id
    else:
        wx_id = gid()
        Q.Wx.save(
            _id=wx_id,
            biz=int(b64decode(_biz)),
            wx_name=wx_name,
            wx_alias=wx_alias
        )

    wx_args = dict(
        wx_id=wx_id,
        idx=int(url['idx']),
        mid=int(url['mid'])
    )

    wx_post = Q.WxPost.get(**wx_args)
    if wx_post:
        wx_post_id = wx_post._id
    else:
        wx_post_id = gid()
        Q.WxPost.upsert(
            _id=wx_post_id
        )(
            title=title,
            sn=int(url['sn'], 16),
            desc=desc,
            author=author,
            src=src,
        )

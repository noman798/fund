from ztz.redis.sync.cid import gid
from db import Q
from urllib.parse import urlparse, parse_qsl
from base64 import b64decode
from binascii import a2b_hex


def post_save(url, src, title, desc, html, author, wx_name, wx_alias, create_time):
    url = urlparse(url)
    url = dict(parse_qsl(url.query))
    _biz = int(b64decode(url['__biz']))
    biz = Q.Wx.get(biz=_biz)
    if biz:
        wx_id = biz._id
    else:
        wx_id = gid()
        Q.Wx.save(
            _id=wx_id,
            biz=_biz,
            name=wx_name,
            en=wx_alias
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
            sn=a2b_hex(url['sn'].encode('ascii')),
            desc=desc,
            author=author or None,
            src=src or None,
            html=html,
            time=int(create_time),
            **wx_args
        )
    return wx_post_id

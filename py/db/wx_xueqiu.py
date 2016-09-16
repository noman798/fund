from ztz.redis.sync.cid import gid
from db import Q
from ztz.backend.website.xueqiu import Xueqiu
from base64 import b64encode
import re
from html import escape
from ztz.util.url_short import url_short
from binascii import b2a_hex

RE_BR = re.compile(r'\s*<br\s*/?\s*>\s*', re.I)


def wx_xueqiu_post_save(user_id, post_id):
    o = Q.WxXueqiuPost.get(user_id=user_id, post_id=post_id)
    if not o:
        _id = gid()
        Q.WxXueqiuPost.upsert(post_id=post_id, user_id=user_id)(_id=_id)


def wx_xueqiu_sync():
    pre_user_id = 0
    for i in Q.WxXueqiuPost.find(
        xueqiu__exists=False
    ).iter(
        sort=[['user_id', 1], ['_id', -1]]
    ):
        post = Q.WxPost.get(i.post_id)
        html = post.html
        html = RE_BR.sub('', html).replace(
            "<p></p>", "<br>"
        ).replace(
            "</p><br>", "</p>"
        )
        if post.desc and post.desc not in html:
            html = ("<p>%s</p>─────────────────<br>" % post.desc) + html

        total = len(html)
        limit = 19000

        wx = Q.Wx.get(post.wx_id)
        url = "http://mp.weixin.qq.com/s?__biz=%s&mid=%s&idx=%s&sn=%s" % (
            b64encode(str(wx.biz).encode('ascii')).decode('ascii'),
            post.mid,
            post.idx,
            b2a_hex(post.sn).decode('ascii')
        )
        url = url_short(url)
        if total > limit:
            html = html[:limit]
            html = html[:html.rfind("<")]
            html += """<p>… … …</p><p>还有 %s 字，请移步原文链接: <a href="%s">%s</a></p>""" % (
                len(total) - limit,
                url,
                url
            )
        else:
            html = """<p>原文链接 : <a href="%s">%s</a></p>""" % (url, url)

        if post.author and post.author != wx.wx_name:
            html += ("<p>作者 ：%s</p>" % escape(post.author))

        html += "<p>转自微信公众号 ：%s ( %s ) </p>" % (wx.name, wx.en)

        if i.user_id != pre_user_id:
            xueqiu = Xueqiu()
            xueqiu.login(*tuple(Q.Qq.get(i.user_id).xueqiu))
        r = xueqiu.new_post(post.title, html)
        if 'target' in r:
            url = r['target']
            print(url)
            Q.WxXueqiuPost.upsert(_id=post._id)(xueqiu=url)
        else:
            print(r)


if __name__ == "__main__":
    wx_xueqiu_sync()

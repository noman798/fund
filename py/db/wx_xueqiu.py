from ztz.redis.sync.cid import gid
from db import Q
from ztz.backend.website.xueqiu import Xueqiu
from base64 import b64encode
import re
from html import escape
from ztz.util.url_short import url_short
from binascii import b2a_hex
from ztz.util.extract import extract

RE_BR = re.compile(r'\s*<br\s*/?\s*>\s*', re.I)
RE_STYLE = re.compile(r'\s+style="[^"]*"', re.I)
RE_IMG = re.compile(r'<img[^>]*>', re.I)


def wx_xueqiu_post_save(user_id, post_id):
    o = Q.WxXueqiuPost.get(user_id=user_id, post_id=post_id)
    if not o:
        _id = gid()
        Q.WxXueqiuPost.upsert(post_id=post_id, user_id=user_id)(_id=_id)


def img_upload_xueqiu(xueqiu):
    def _(img):
        img = img.group(0)
        src = extract('data-src="', '"', img)
        src = xueqiu.upload_img(src)
        return """<img src="%s">""" % src
    return _


def wx_xueqiu_sync():
    pre_user_id = 0
    for wx_xueqiu_post in Q.WxXueqiuPost.iter(
        xueqiu__exists=False,
        sort=[['user_id', 1], ['_id', -1]]
    ):

        post = Q.WxPost.get(wx_xueqiu_post.post_id)
        html = post.html
        html = RE_STYLE.sub('', RE_BR.sub('', html)).replace(
            "<p></p>", "<br>"
        ).replace(
            "</p><br>", "</p>"
        ).replace("<span>", '').replace("</span>", '').strip()
        if post.desc and post.desc not in html:
            html = ("<p>%s</p>───<br>" % post.desc) + html
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
                total - limit,
                url,
                url
            )
        else:
            html += """<p>原文链接 : <a href="%s">%s</a></p>""" % (url, url)

        if wx_xueqiu_post.user_id != pre_user_id:
            xueqiu = Xueqiu()
            xueqiu.login(*tuple(Q.Qq.get(wx_xueqiu_post.user_id).xueqiu))

        html = RE_IMG.sub(img_upload_xueqiu(xueqiu), html)

        if post.author and post.author != wx.name:
            html += ("<p>作者 ：%s</p>" % escape(post.author))

        html += "<p>转自微信公众号 ：%s ( %s ) </p>" % (wx.name, wx.en)
        r = xueqiu.new_post(post.title, html)
        if 'target' in r:
            url = r['target']
            Q.WxXueqiuPost.upsert(_id=wx_xueqiu_post._id)(xueqiu=url)
        else:
            print(r)


if __name__ == "__main__":
    wx_xueqiu_sync()

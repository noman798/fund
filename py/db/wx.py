from ztz.redis.sync.cid import gid
from __init__ import Q

def post_save(url, title, desc, html, author, src, alias):
    print(title)
    print(desc)
    print(html)
    print(author)
    print(src)
    print(url)
    print(alias)

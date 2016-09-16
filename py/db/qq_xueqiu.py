from ztz.redis.sync.cid import gid
from db import Q


def wx_xueqiu_post_save(user_id, post_id):
    o = Q.WxXueqiuPost.get(user_id=user_id, post_id=post_id)
    if not o:
        _id = gid()
        Q.WxXueqiuPost.upsert(post_id=post_id, user_id=user_id)(_id=_id)

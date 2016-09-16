from ztz.redis.sync.cid import gid
from db import Q


def qq_save(qq):
    qq = int(qq)
    o = Q.QQ.get(qq=qq)
    if not o:
        o = Q.QQ.upsert(qq=qq)(_id=gid())
    return o._id

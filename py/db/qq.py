from ztz.redis.sync.cid import gid
from db import Q


def qq_save(qq):
    qq = int(qq)
    o = Q.get(qq=qq)
    if not o:
        o = Q.upsert(qq=qq)(_id=gid())
    return o._id

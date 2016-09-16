from ztz.redis.sync.cid import gid
from db import Q


def qq_save(qq):
    qq = int(qq)
    o = Q.Qq.get(qq=qq)
    if o:
        _id = o._id
    else:
        _id = gid()
        o = Q.Qq.upsert(qq=qq)(_id=_id)
    return _id

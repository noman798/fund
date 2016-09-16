from db import Q
import pymongo


Q.Wx.ensure_index('biz', unique=True)
Q.Qq.ensure_index('qq', unique=True)
Q.WxPost.ensure_index(
    [
        ("wx_id", pymongo.DESCENDING),
        ("idx", pymongo.DESCENDING),
        ("mid", pymongo.DESCENDING),
    ],
    unique=True
)
Q.WxXueqiuPost.ensure_index(
    [
        ("user_id", pymongo.DESCENDING),
        ("post_id", pymongo.DESCENDING),
    ],
    unique=True
)

from db import Q
import pymongo


Q.Wx.ensure_index('biz', unique=True)
Q.WxPost.ensure_index(
    [
        ("wx_id", pymongo.DESCENDING),
        ("idx", pymongo.DESCENDING),
        ("mid", pymongo.DESCENDING),
    ],
)

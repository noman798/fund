import requests
from ztz.util.extract import extract
from json import loads, dumps

USER = """
100016 真谛LOL 294059691@qq.com
101467 碧海潮生 95880171@qq.com
108087 邢俊生 2308070706@qq.com
107523 lanhero lanhero@gmail.com
108411 abjkl abjkl@163.com
101050 Auxten 623369873@qq.com
107611 小魔@优雅穿梭 reliance@126.com
107589 su27 damn.su@gmail.com
108401 shirp xiaoli.peng@foxmail.com
108064 如意 1373169587@qq.com
""".strip(" \n").split("\n")

result = []
for i in USER:
    user_id, name, mail = i.split()
    r = requests.get("http://42btc.us/god/log?user_id=%s" % user_id, headers={
        "Cookie": "S=oIYBAAAAAAA5SwvZ-khu4E7lvuE;"
    })
    data = extract(
        "var DATA=",
        "</script>",
        r.content.decode('utf-8')
    )
    data = loads(data)
    result.append(
        (user_id, name, mail, data)
    )

with open("user.json", "w") as f:
    f.write(dumps(result))

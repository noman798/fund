user_json = require "./user.json"

process.env.NODE_PATH += (":"+__dirname+"/../../ws/src/")
require('module').Module._initPaths()

PG = require "pg.coffee"

find_begin_user = ->
    begin = 9007199254740992
    begin_line = 0

    total = 0
    for [user_id, user_name, user_mail, li] in user_json
        count = 0
        for line in li
            time = new Date(line[4]).getTime()
            if time < begin
                begin = time
                begin_line = [user_id, line]

            count += line[1]
        total += count

    console.log total
    console.log begin_line
    return begin_line[0]

begin_user_dividend = ->
    rate_li = []
    begin_user_id = find_begin_user()
    for [user_id, user_name, user_mail, li] in user_json
        if user_id != begin_user_id
            continue

        count = 0
        li.reverse()
        for line in li
            if line[0] == "分红"
                time = new Date(line[4]).getTime()
                rate = line[1]/count
                rate_li.push ([time, rate, '分红'])
            count+=line[1]
    rate_li

RATE_LI =  begin_user_dividend()

user_log_li = ->
    result = []
    for [user_id, user_name, user_mail, _li] in user_json
        li = []
        for [kind, amount, currency, admin, time, xxx] in _li
            if kind == "分红"
                continue
            if currency != "¥"
                console.log "!!!!!!!!!!", user_id, currency
            else
                li.push [(new Date(time).getTime()), amount, kind]
        result.push [user_mail , li]
    result

USER_LOG_LI = user_log_li()

KIND = {
    "入资":1
    "提现":2
    "分红":3
}

_TO_INSERT = []
_insert = (time, kind, user_id, val)->
    _TO_INSERT.push [time, kind, user_id, val]
_insert_all = ->
    _TO_INSERT.sort (a,b)->
        a[0] - b[0]
    PG.raw("SELECT id from public.user_share_log where user_id=? and time=?",[user_id, time]).then (id)->
        if id.rowCount == 0
            if not kind in KIND
                console.log kind, KIND[kind]
            else
                if val
                    console.log "num", val, kind
                    PG.raw("""INSERT INTO public.user_share_log (kind, user_id, time, n) VALUES (?,?,?,?) RETURNING id""", [KIND[kind], user_id, time, val]).then (id) ->
                        console.log("insert ", id)

user_log_by_rate = (mail2id)->
    total = 0
    for [user_mail, li] in USER_LOG_LI
        user_id = mail2id[user_mail]
        console.log "user_id", user_id
        li.push.apply li, RATE_LI
        li.sort (a,b)->
            a[0] - b[0]
        count = 0
        for [time, val, kind] in li
            if kind == "分红"
                val = count*val
                count = count+val
            else
                count += val
            _insert(time, kind, user_id, val)


            #console.log new Date(time).toISOString(), val, kind
        total += count
    console.log total
    _insert_all()

user_rate = ->
    v = 1
    for i in RATE_LI
        v *= (1+i[1]*2)
    v
user_rate()

PG.raw(
    "SELECT id::int,mail from public.user"
).then (li)->
    mail2id = {}
    for i in li.rows
        mail2id[i.mail] = i.id
    user_log_by_rate(mail2id)

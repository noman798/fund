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
                count = count*(1+val)
            else
                count += val
            PG.raw("SELECT id from public.user_share_log where user_id=? and time=?",[user_id, time]).then (id)->
                if id.rowCount == 0

            #console.log new Date(time).toISOString(), val, kind
        total += count
    console.log total


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

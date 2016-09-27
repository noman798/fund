process.env.NODE_PATH += (":"+__dirname+"/../../ws/src/")
require('module').Module._initPaths()

PG = require "pg.coffee"

module.exports = {
    KIND : {
        "入资":1
        "提现":2
        "分红":3
    }
    user_share_new_by_id : (user_id, kind, n)->
        date = new Date()
        time = parseInt(date.getTime()/1000)
        PG.raw("""INSERT INTO public.user_share_log (kind, user_id, time, n) VALUES (?,?,?,?) RETURNING id""", [KIND[kind], user_id, time, val])

    user_share_new_by_mail : (mail, kind, n)->
        PG.raw("""INSERT INTO public.user_share_log (kind, user_id, time, n) VALUES (?,?,?,?) RETURNING id""", [KIND[kind], user_id, time, val])
}

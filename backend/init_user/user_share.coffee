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
        PG.raw("""INSERT INTO public.user_share_log (kind, user_id, time, n) VALUES (?,?,?,?) RETURNING id""", [@KIND[kind], user_id, time, n])

    user_share_new_by_mail : (mail, kind, n)->
        self = @
        PG.raw("""SELECT id::int FROM public.user WHERE mail=?""", [mail.toLowerCase()]).then (li)->
            id = li.rows[0]
            if id
                id = id.id
                self.user_share_new_by_id(id, kind, n)
}

module.exports.user_share_new_by_mail("man@tz.world", "入资", "0.01")

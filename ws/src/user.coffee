logined = require('_util/logined.coffee')
PG = require("pg.coffee")

module.exports = {
    share : logined ->
        ID = @ID
        share_now = yield PG.raw("SELECT n::float FROM user_share WHERE id=?",[ID])
        share_now = share_now.rows[0]
        if share_now
            share_now = share_now.n
        else
            share_now = 0

        share_li = []
        _li = (yield PG.raw("""SELECT kind::int,n::float,"time"::int,txt FROM user_share_log WHERE user_id=? ORDER BY time DESC""",[ID])).rows
        for i in _li
            share_li.push [i.kind, i.n, i.time, i.txt]

        return [share_now, share_li]
        # id_li = []
        # share_dict = {}
        # for i in share_li.rows
        #     n = parseFloat i.n.toFixed(3)
        #     id_li.push [i.id]
        #     share_dict[i.id] = i.n

        # user_li = yield PG.raw("SELECT id, name, mail FROM public.user WHERE id IN (#{id_li.join(',')})")

        # result = []
        # for i in user_li.rows
        #     result.push [i.id, i.name, i.mail, share_dict[i.id]]

        # sum = parseFloat (yield PG.raw("SELECT n::float FROM user_share_sum WHERE id=0")).rows[0].n.toFixed(3)

        # return [sum, result]


}

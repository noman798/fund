admined = require('_util/admined.coffee')
PG = require("pg.coffee")

module.exports = {
    user_share : admined ->
        share_li = yield PG.raw("SELECT id::int, n::float FROM user_share")
        id_li = []
        share_dict = {}
        for i in share_li.rows
            n = parseFloat i.n.toFixed(3)
            id_li.push [i.id]
            share_dict[i.id] = i.n

        user_li = yield PG.raw("SELECT id, name, mail FROM public.user WHERE id IN (#{id_li.join(',')})")

        result = []
        for i in user_li.rows
            result.push [i.id, i.name, i.mail, share_dict[i.id]]

        sum = parseFloat (yield PG.raw("SELECT n::float FROM user_share_sum WHERE id=0")).rows[0].n.toFixed(3)

        return [sum, result]


}

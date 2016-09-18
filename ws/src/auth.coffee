JWT = require('jsonwebtoken')
CONFIG = require('config.coffee')
PG = require("pg.coffee")

module.exports = {
    is_admin:->
        li = yield PG.select(1).from('user_admin').where('id', @ID)
        yield li.length


    init:(token)->
        user = JWT.verify(token, CONFIG.WDOG.SECRET)
        r = yield PG.raw(
            "INSERT INTO public.user (wdog_id, mail, name) VALUES (?, ?, ?) ON CONFLICT (wdog_id) DO UPDATE SET mail = ?, name = ? RETURNING id"
            [
                "0000"+user.user_id
                user.email
                user.name
                user.email
                user.name
            ]
        )
        @ID = r.rows[0].id

}
# INSERT INTO distributors (did, dname)
#     VALUES (5, 'Gizmo Transglobal'), (6, 'Associated Computing, Inc')
#     ON CONFLICT (did) DO UPDATE SET dname = EXCLUDED.dname;


JWT = require('jsonwebtoken')
CONFIG = require('config.coffee')
PG = require("pg.coffee")

module.exports = {
    is_admin:->
        ID = @ID
        new Promise (resolve)->
            li = await PG.select(1).from('user_admin').where('id', ID)
            resolve(li.length)


    init:(token)->
        self = @
        user = JWT.verify(token, CONFIG.WDOG.SECRET)
        PG.raw(
            "INSERT INTO public.user (wdog_id, mail, name) VALUES (?, ?, ?) ON CONFLICT (wdog_id) DO UPDATE SET mail = ?, name = ? RETURNING id"
            [
                "0000"+user.user_id
                user.email
                user.name
                user.email
                user.name
            ]
        ).then(
            (r)->
                self.ID = r.rows[0].id
        )

}
# INSERT INTO distributors (did, dname)
#     VALUES (5, 'Gizmo Transglobal'), (6, 'Associated Computing, Inc')
#     ON CONFLICT (did) DO UPDATE SET dname = EXCLUDED.dname;


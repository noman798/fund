JWT = require('jsonwebtoken')
CONFIG = require('config.coffee')
PG = require("pg.coffee")

module.exports = {
    init:(token)->
        user = JWT.verify(token, CONFIG.WDOG.SECRET)
        console.log PG.returning('id').raw(
            "INSERT INTO user (wdog_id, mail, name) VALUES (?, ?, ?) ON CONFLICT (wdog_id) DO UPDATE SET mail = ?, name = ?"
            [
                user.user_id
                user.email
                user.name
                user.email
                user.name
            ]
        ).then(
            (r)->
                console.log(r)
        ).catch (err)->
            console.log "ERR", err

        console.log user.user_id, user.email, user.name, user.exp
}
# INSERT INTO distributors (did, dname)
#     VALUES (5, 'Gizmo Transglobal'), (6, 'Associated Computing, Inc')
#     ON CONFLICT (did) DO UPDATE SET dname = EXCLUDED.dname;


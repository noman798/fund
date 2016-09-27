JWT = require('jsonwebtoken')
CONFIG = require('config.coffee')
PG = require("pg.coffee")
admined = require('_util/admined.coffee')

module.exports = {
    is_admin:admined ->
        return 1

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
        return
}

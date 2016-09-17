JWT = require('jsonwebtoken')
CONFIG = require('config.coffee')
PG = require("pg.coffee")

module.exports = {
    init:(token)->
        user = JWT.verify(token, CONFIG.WDOG.SECRET)
        console.log "!!!"
        console.log PG.raw(
            "INSERT INTO user (wdog_id, mail, name) values (?, ?, ?) ON CONFLICT (wdog_id) DO UPDATE SET mail = ?, name = ?"
            [
                user.user_id
                user.email
                user.name
                user.email
                user.name
            ]
        )
        console.log user.user_id, user.email, user.name, user.exp
}

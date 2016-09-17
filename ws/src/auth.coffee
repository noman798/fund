CONFIG = require('config.coffee')
JWT = require('jsonwebtoken')
PG = require("pg.coffee")

module.exports = {
    init:(token)->
        user = JWT.verify(token, CONFIG.WDOG.SECRET)
        console.log user.user_id, user.email, user.name, user.exp
        PG.connect().then ->
            console.log "!!!"

}

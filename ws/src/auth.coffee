require('db.coffee')
CONFIG = require('config.coffee')
jwt = require('jsonwebtoken')

module.exports = {
    init:(token)->
        user = jwt.verify(token, CONFIG.WDOG.SECRET)
        console.log user.user_id, user.email, user.name, user.exp

}

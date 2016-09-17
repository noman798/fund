CONFIG = require('config.coffee')
jwt = require('jsonwebtoken')

module.exports = {
    init:(token)->
        # console.log jwt.verify(token)
        console.log jwt.decode(token)
}

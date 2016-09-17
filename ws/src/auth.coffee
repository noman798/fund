CONFIG = require('config.coffee')
jwt = require('jsonwebtoken')

console.log CONFIG

module.exports = {
    init:(token)->
        # console.log jwt.verify(token)
        console.log jwt.decode(token)
}

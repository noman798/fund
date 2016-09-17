jwt = require('jsonwebtoken')

module.exports = {
    init:(token)->
        console.log jwt.verify(token)
}

logined = require('_util/logined.coffee')
PG = require("pg.coffee")
co = require('co')

module.exports = (func)->
    logined ->
        is_admin = @IS_ADMIN
        if is_admin == undefined
            is_admin = @IS_ADMIN = (
                yield PG.select(1).from('user_admin').where(
                    'id', @ID
                )
            ).length

        if is_admin
            return co(func.apply(@, arguments))
        else
            @send "/ auth/admin"
            return 0

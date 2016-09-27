admined = require('_util/admined.coffee')
PG = require("pg.coffee")

module.exports = {
    user_share : admined ->
        li = yield PG.raw("SELECT id, n FROM user_share")
        result = []
        for i in li.rows
            result.push [i.id, i.n]

        return result


}

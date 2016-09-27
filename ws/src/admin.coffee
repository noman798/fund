admined = require('_util/admined.coffee')
PG = require("pg.coffee")

module.exports = {
    user_share : admined ->
        li = yield PG.raw("SELECT id::int, n::float FROM user_share")
        result = []
        total = 0
        for i in li.rows
            n = parseFloat i.n.toFixed(3)
            result.push [i.id, n]
            total += n
        return [total, result]


}

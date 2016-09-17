CONFIG = require('config.coffee')
module.exports = require('knex')({
    # debug:CONFIG.DEBUG
    client: 'pg',
    connection: CONFIG.PSQL
    searchPath: 'public'
    pool: { min: 0, max: 7 }
    acquireConnectionTimeout: 10000
}).on(
    'query-error'
    (error, obj)->
        console.log error
)


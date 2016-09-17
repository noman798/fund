CONFIG = require('config.coffee')
pg = require('pg').native
Pool = pg.Pool
Client = pg.Client

module.exports = POOL = new Pool(CONFIG.PSQL)


POOL.on(
    'error'
    (err, client) ->
        console.error('PG ERROR', err.message, err.stack)
)


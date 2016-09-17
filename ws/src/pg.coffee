CONFIG = require('config.coffee')
require('knex')({
    client: 'pg',
    connection: CONFIG.PSQL,
    searchPath: 'knex,public'
    pool: { min: 0, max: 7 }
    acquireConnectionTimeout: 10000
})

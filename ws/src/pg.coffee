CONFIG = require('config.coffee')
require('knex')({
    client: 'pg',
    connection: CONFIG.PSQL,
    searchPath: 'knex,public'
})

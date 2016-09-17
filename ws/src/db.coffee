CONFIG = require('config.coffee')
pg = require('pg')
console.log CONFIG.PSQL
client = new pg.Pool(CONFIG.PSQL)


CONFIG = require('config.coffee')
pg = require('pg')

client = new pg.Pool(CONFIG.PSQL)


CONFIG = require('config.coffee')
pg = require('pg').native
Pool = pg.Pool
Client = pg.Client

client = new Pool(CONFIG.PSQL)


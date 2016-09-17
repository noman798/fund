CONFIG = require('config.coffee')
pg = require('pg').native
Pool = pg.Pool
Client = pg.Client

module.exports = new Pool(CONFIG.PSQL)


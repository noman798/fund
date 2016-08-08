require('../scss/comm.scss')
vue = require("vue")
vue.config.debug = true

app = require("../vue/app.slim")
console.log(app)
new vue(app)



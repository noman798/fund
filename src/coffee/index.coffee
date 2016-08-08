require('../scss/comm.scss')
vue = require("vue")
vue.config.debug = true

app = require("../vue/app.vue")
console.log(app)
new vue(app)



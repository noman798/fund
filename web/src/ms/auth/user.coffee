
store = require 'store'

html = $ require("./_base.coffee")
html.find('.txt').html ""

MS 'auth-user', html.html() , {
}

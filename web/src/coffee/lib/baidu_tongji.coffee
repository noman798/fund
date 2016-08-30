CONFIG = require 'config.coffee'
window._hmt = window._hmt || []
hm = document.createElement("script")
hm.src = "//hm.baidu.com/hm.js?#{CONFIG.BAIDU_TONGJI}"
s = document.getElementsByTagName("script")[0]
s.parentNode.insertBefore(hm, s)


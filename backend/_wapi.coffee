#! /usr/bin/env coffee

_config = "#{process.cwd()}/config.coffee"
try
    CONFIG = require(_config)
catch error
    console.log("""
出错了！！！

#{_config} 不存在，请创建。

格式样板：

module.exports = {
    WILDDOG:{
        KEY : "访问 http://wilddog.com > 应用 > 身份认证 > 登录方式 · 页面底部 > 超级密钥 获取第一个超级密钥"
        SITE : "你的应用ID"
    }
}
""")
    process.exit()

WilddogTokenGenerator = require("wilddog-token-generator")
request = require('request')

tokenGenerator = new WilddogTokenGenerator(CONFIG.WILDDOG.KEY)


URL = "https://#{CONFIG.WILDDOG.SITE}.wilddogio.com/"
querystring = require('querystring')

_api = (method, path, dict, callback)->
    token = tokenGenerator.createToken({uid: 0}, {
        admin:true
        expires: new Date().getTime() + 100000000
    })
    data = {}
    if typeof(dict) == 'function'
        callback = dict
        dict = {}
    if typeof(dict) == 'string'
        data.body = dict
        dict = {}

    param = querystring.stringify(dict)
    url = """#{URL}#{path}.json?auth=#{token}"""
    if param
        url += ("&"+param)

    data.method = method
    data.url = url
    console.log(data)
    request(
        data
        callback
    )

module.exports = {
    get : (path, dict, callback)->
        _api("get", path, dict, callback)
    put : (path, dict, callback)->
        _api("put", path, dict, callback)
}


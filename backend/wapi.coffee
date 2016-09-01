module.exports = (site, key) ->
    WilddogTokenGenerator = require("wilddog-token-generator")
    request = require('request')

    tokenGenerator = new WilddogTokenGenerator(key)


    URL = "https://#{site}.wilddogio.com/"
    querystring = require('querystring')

    _api = (method, path, dict, callback)->
        begin = new Date().getTime()
        token = tokenGenerator.createToken({uid: 0}, {
            admin:true
            expires: 100000000+begin
            iat:begin
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
        request(
            data
            callback
        )

    {
        url :  URL
        get : (path, dict, callback)->
            _api("get", path, dict, callback)
        put : (path, dict, callback)->
            _api("put", path, dict, callback)
    }

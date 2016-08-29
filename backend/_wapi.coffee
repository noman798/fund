#! /usr/bin/env coffee

CONFIG = require('./config.coffee')
Wilddog = require("wilddog")
WilddogTokenGenerator = require("wilddog-token-generator")
request = require('request')

tokenGenerator = new WilddogTokenGenerator(CONFIG.WILDDOG.KEY)


URL = "https://#{CONFIG.WILDDOG.DB}.wilddogio.com/"
querystring = require('querystring')

_api = (method, path, dict, callback)->
    token = tokenGenerator.createToken({uid: 0}, {
        admin:true,expires: new Date().getTime() + 100000000
    })
    if typeof(dict) == 'function'
        callback = dict
        dict = {}

    param = querystring.stringify(dict)
    url = """#{URL}#{path}.json?auth=#{token}"""
    if param
        url += ("&"+param)

    request[method](
        url,callback
    )

module.exports = {
    get : (path, dict, callback)->
        _api("get", path, dict, callback)
}


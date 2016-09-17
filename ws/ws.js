process.env.NODE_PATH += (":"+__dirname+"/src");
require('module').Module._initPaths();
require('coffee-script/register');
module.exports = require("./ws.coffee");

process.env.NODE_PATH += (":"+__dirname);
require('module').Module._initPaths();
require('coffee-script/register');
module.exports = require("./ws.coffee");

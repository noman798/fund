webpackDevServer = require("webpack-dev-server")
webpack = require("webpack")


config = require("./webpack.config.coffee")
config.entry.app.unshift("webpack-dev-server/client?http://0.0.0.0:8081")

compiler = webpack(config)

server = new webpackDevServer(compiler, {
    historyApiFallback: {
        rewrites: [{
            from: /\/\d\..*\.js(\.map)?/
            to: (context) -> context.match[0]
        }]
    }
})
server.listen(8081)


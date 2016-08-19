webpackDevServer = require("webpack-dev-server")
webpack = require("webpack")


config = require("./webpack.config.coffee")
# config.entry.app.unshift("webpack-dev-server/client?http://0.0.0.0:8081")

compiler = webpack(config)

server = new webpackDevServer(compiler, {
    stats: { colors: true , process:true}
    contentBase:"./dist"
    historyApiFallback: {
        rewrites: [
            {
                from: /\/(\d\..*\.js(\.map)?)/
                to: (context) ->
                    "/js"+context.match[0]
            }
            {
                from: /\/auth\/.*/
                to: (context) ->
                    "/"
            }
        
        ]
    }
})
server.listen(8081)


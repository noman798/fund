isProduction = (process.env.NODE_ENV == 'production')

HtmlWebpackPlugin = require('html-webpack-plugin')

plugins = [
    new HtmlWebpackPlugin({
        template: 'index.html.slim'
    })
]

if isProduction
    plugins.push (
        new webpack.optimize.UglifyJsPlugin({
            test: /\.js$/,
            compress: {
                warnings: false
            }
        })
    )


module.exports =
    entry: './entry.coffee'
    output:
        path: __dirname
        filename: 'bundle.js'
    devtool: "source-map"
    devServer:
        contentBase: "./dev"
        #hot: true
        #inline: true
    module:
        loaders: [
          {test: /\.css$/, loader: 'style!css'}
          {
              test: /\.scss$/,
              loaders: ["style", "css?sourceMap", "sass?sourceMap"]
          }
          {
              test: /\.html\.slim$/
              loader: "html!slm"
          }

        ]
    plugins:plugins


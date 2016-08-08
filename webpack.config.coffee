isProduction = (process.env.NODE_ENV == 'production')
webpack = require('webpack')

HtmlWebpackPlugin = require('html-webpack-plugin')

if isProduction
    sourceMap = "?sourceMap"

exports = {
    entry: './entry.coffee'
    output:
        path: __dirname
        filename: 'bundle.js'
    devServer:
        contentBase: "./dev"
    module:
        loaders: [
          {test: /\.css$/, loader: 'style!css'}
          {
              test: /\.scss$/,
              loaders: ["style", "css#{sourceMap}", "sass#{sourceMap}"]
          }
          {
              test: /\.html\.slim$/
              loader: "html!slm"
          }

        ]
    plugins: [
        new HtmlWebpackPlugin({
            template: 'index.html.slim'
        })
    ]
}


if isProduction
    exports.plugins.push (
        new webpack.optimize.UglifyJsPlugin({
            test: /\.js$/,
            compress: {
                warnings: false
            }
        })
    )
else
    exports.devtool = "source-map"

module.exports = exports


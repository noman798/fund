isProduction = (process.env.NODE_ENV == 'production')

outputDir = "./dist"

webpack = require('webpack')

HtmlWebpackPlugin = require('html-webpack-plugin')

if isProduction
    sourceMap = "?sourceMap"

exports = {
    entry: './entry.coffee'
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
            inject: 'body'
        })
    ]
    output: {
        path: outputDir
        filename: 'js/[name].bundle.js',
        # publicPath: isProduction()? 'http://******' : 'http://localhost:3000',
    }
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


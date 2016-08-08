isProduction = (process.env.NODE_ENV == 'production')

outputDir = "./dist"

webpack = require('webpack')

HtmlWebpackPlugin = require('html-webpack-plugin')

if isProduction
    sourceMap = "?sourceMap"
else
    sourceMap = ""

exports = {
    entry: './src/coffee/index.coffee'
    devServer:
        contentBase: "./dev"
    module:
        loaders: [
          {test: /\.css$/, loader: 'style!css'}
          {
              test: /\.scss$/
              loaders: ["style", "css#{sourceMap}", "sass#{sourceMap}"]
          }
          {
              test: /\.slim$/
              loader: "html!slm"
          }

        ]
    
    plugins: [
        new webpack.optimize.CommonsChunkPlugin({
            name: 'commons',
            filename: 'js/commons.js',
        })
        new HtmlWebpackPlugin({
            template: './src/slim/index.slim'
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


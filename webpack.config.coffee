isProduction = (process.env.NODE_ENV == 'production')

path = require("path")
webpack = require('webpack')
outputDir = path.join(__dirname,"dist")

HtmlWebpackPlugin = require('html-webpack-plugin')

if isProduction
    sourceMap = "?sourceMap"
else
    sourceMap = ""

exports = {
    entry: './src/coffee/init.coffee'
    output: {
        path: outputDir
        chunkFilename: 'js/[name].[chunkhash].js'
        filename: 'js/[name].[chunkhash].js'
        # publicPath: outputDir
        # publicPath: isProduction()? 'http://******' : 'http://localhost:3000'
    }
    devServer:
        contentBase: "./dist"
    module:
        loaders: [
            # { test: './src/coffee/index.coffee', loader: "exports?avalon!coffee-loader" }
            { test: /\.coffee$/, loader: "coffee-loader" }

            {test: /\.css$/, loader: 'style!css'}
            {
                test: /\.scss$/
                loaders: ["style", "css#{sourceMap}", "sass#{sourceMap}"]
            }
            {
                test: /\.slm$/
                loader: "html!slm"
            }
            {
                test: /\.(woff|woff2|ttf|eot|svg)(\?v=[0-9]\.[0-9]\.[0-9])?$/
                loader: 'file-loader?name=./font/[name].[ext]'
            }
            {
                test: /\.(png|jpg|gif)$/
                loader: 'url-loader?limit=8192&name=./img/[name].[ext]'
            }
        ]

    plugins: [
        new webpack.optimize.CommonsChunkPlugin({
            name: 'commons',
            filename: 'js/commons.js',
        })
        new HtmlWebpackPlugin({
            template: './src/slm/index.slm'
            inject: 'body'
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


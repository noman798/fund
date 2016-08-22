isProduction = (process.env.NODE_ENV == 'production')
ExtractTextPlugin = require('extract-text-webpack-plugin')
path = require("path")
webpack = require('webpack')
outputDir = path.join(__dirname,"dist")

HtmlWebpackPlugin = require('html-webpack-plugin')
COFNIG = require('./config.coffee')

output = {
    path: outputDir
}

if isProduction
    sourceMap = ""
    output.chunkFilename = '[chunkhash].js'
    output.filename = '[chunkhash].js'
    output.publicPath = COFNIG.CDN
    output_cdn = {
        publicPath:COFNIG.CDN
    }
else
    output_cdn = {}
    sourceMap = "?sourceMap"
    output.chunkFilename = 'js/[name].js'
    output.filename = 'js/[name].js'

exports = {
    entry: './src/coffee/init.coffee'
    output: output
    devServer:
        contentBase: "./dist"
    module:
        loaders: [
            # { test: './src/coffee/index.coffee', loader: "exports?avalon!coffee-loader" }
            { test: /\.coffee$/, loader: "coffee-loader" }

            {test: /\.css$/, loader: 'style!css'}
            {
                test: /\.scss$/
                loader: ExtractTextPlugin(
                    "style"
                    "css#{sourceMap}"
                    "sass#{sourceMap}"
                    output_cdn
                )
            }
            {
                test: /\.slm$/
                loader: "raw!html-minify!slm"
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
            filename: '[chunkhash].js',
        })
        new HtmlWebpackPlugin({
            template: './src/slm/index.slm'
            inject: 'body'
            minify:{
                removeScriptTypeAttributes:true
                removeAttributeQuotes:true
            }
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
            output:{
                comments: false
            }
        })
    )
else
    exports.devtool = "source-map"

module.exports = exports


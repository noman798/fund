isProduction = (process.env.NODE_ENV == 'production')

path = require("path")
webpack = require('webpack')
outputDir = path.join(__dirname,"dist")

HtmlWebpackPlugin = require('html-webpack-plugin')
COFNIG = require('./config.coffee')

output = {
    path: outputDir
}

if isProduction
    sourceMap = "?sourceMap"
    output.chunkFilename = '[chunkhash].js'
    output.filename = '[chunkhash].js'
    output.publicPath = COFNIG.CDN
else
    sourceMap = ""
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

            {test: /\.css$/, }
            {
                test: /\.(s?css)$/
                loaders: ["style", "css#{sourceMap}", "sass#{sourceMap}"]
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
            filename: '[chunkhash]',
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
        })
    )
else
    exports.devtool = "source-map"

module.exports = exports


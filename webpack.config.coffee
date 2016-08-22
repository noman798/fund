isProduction = (process.env.NODE_ENV == 'production')
path = require("path")
webpack = require('webpack')
outputDir = path.resolve(__dirname, 'dist')

COFNIG = require('./config.coffee')

OptimizeCssAssetsPlugin = require('optimize-css-assets-webpack-plugin')
HtmlWebpackPlugin = require('html-webpack-plugin')
ExtractTextPlugin = require("extract-text-webpack-plugin")

extractScss = new ExtractTextPlugin("[hash].css")

output = {
    path: outputDir
}

if isProduction
    sourceMap = ""
    # sourceMap = "?prefix=/xxxximg"
    output.chunkFilename = '[chunkhash].js'
    output.filename = '[chunkhash].js'
    output.publicPath = COFNIG.CDN
else
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
                loader: extractScss.extract(
                    ["css#{sourceMap}","sass#{sourceMap}"]
                    {
                        publicPath: if isProduction then COFNIG.CDN else "/"
                    }
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
        extractScss
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
    exports.plugins.push   new OptimizeCssAssetsPlugin({
        assetNameRegExp: /\.css$/,
        cssProcessorOptions: { discardComments: { removeAll: true } }
    })

else
    exports.devtool = "source-map"

module.exports = exports


isProduction = (process.env.NODE_ENV == 'production')
path = require("path")
webpack = require('webpack')
outputDir = path.resolve(__dirname, 'dist')

COFNIG = require('./config.coffee')

OptimizeCssAssetsPlugin = require('optimize-css-assets-webpack-plugin')
HtmlWebpackPlugin = require('html-webpack-plugin')
ExtractTextPlugin = require("extract-text-webpack-plugin")

extractScss = new ExtractTextPlugin("[chunkhash].css")

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
    output.chunkFilename = '[name].js'
    output.filename = '[name].js'
    output.publicPath = "/"

exports = {
    entry: './src/coffee/init.coffee'
    output: output
    resolve: {
        root: __dirname
        alias: {
            # AppStore : 'js/stores/AppStores.js',//后续直接 require('AppStore') 即可
        }
        # extensions: ['', '.js', '.json', '.scss'],
    }

    devServer:
        contentBase: "./dist"
    module:
        loaders: [
            # { test: './src/coffee/index.coffee', loader: "exports?avalon!coffee-loader" }
            { test: /\.coffee$/, loader: "coffee-loader" }
            {
                loader: extractScss.extract(
                    ["css#{sourceMap}","sass#{sourceMap}"]
                    {
                        publicPath: if isProduction then COFNIG.CDN else "//"
                    }
                )
                test: /\.(s?css)$/
            }
            {
                test: /\.slm$/
                loader: "raw!html-minify!slm"
            }
            {
                test: /\.(woff|woff2|ttf|eot|svg)(\?v=[0-9]\.[0-9]\.[0-9])?$/
                loader: 'file-loader?hash=sha512&name=./font/[name].[ext]'
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
        new webpack.DefinePlugin({
            __DEBUG__ : not isProduction
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
    exports.plugins.push   new OptimizeCssAssetsPlugin({
        assetNameRegExp: /\.css$/,
        cssProcessorOptions: { discardComments: { removeAll: true } }
    })

else
    exports.devtool = "source-map"

module.exports = exports


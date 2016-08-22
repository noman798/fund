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
            # "url-loader": require("url-loader")
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
                    'style-loader'
                    ["css-loader?root=/#{sourceMap}","sass#{sourceMap}"]
                    {
                        publicPath: if isProduction then COFNIG.CDN else "//"
                    }
                )
                # loaders:['style-loader',"css-loader?root=/","sass#{sourceMap}"]
                test: /\.(s?css)$/
            }
            {
                test: /\.slm$/
                loader: "raw!html-minify!slm"
            }
            {
                test: /\.(woff|woff2|ttf|eot)(\?v=[0-9]\.[0-9]\.[0-9])?$/
                loader: 'url-loader?limit=1&name=[hash:base64:7].[ext]'
            }
            {
                test: /\.(png|jpg|gif|svg)$/
                # loader: 'url-loader?limit=8192&name=[hash].[ext]'
                loader: 'url-loader?limit=1&name=[hash:base64:7].[ext]'
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


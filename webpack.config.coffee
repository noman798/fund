HtmlWebpackPlugin = require('html-webpack-plugin')

module.exports =
    entry: './entry.coffee'
    output:
        path: __dirname
        filename: 'bundle.js'
    devtool: "source-map"
    devServer:
        contentBase: "./dev"
        hot: true
        inline: true
    module:
        loaders: [
          {test: /\.css$/, loader: 'style!css'}
          {
              test: /\.scss$/,
              loaders: ["style", "css?sourceMap", "sass?sourceMap"]
          }
          {
              test: /\.html\.slim$/
              loader: "slm"
          }

        ]
    plugins :[
        new HtmlWebpackPlugin({
            template: 'index.html.slim'
        })
    ]

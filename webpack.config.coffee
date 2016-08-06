module.exports =
    entry: './entry.coffee'
    output:
        path: __dirname
        filename: 'bundle.js'
    devtool: "source-map"
    module:
        loaders: [
          {test: /\.css$/, loader: 'style!css'}
          {
              test: /\.scss$/,
              loaders: ["style", "css?sourceMap", "sass?sourceMap"]
          }
        ]

module.exports =
    entry: './entry.coffee'
    output:
        path: __dirname
        filename: 'bundle.js'
    module:
        loaders: [
          {test: /\.css$/, loader: 'style!css'}
        ]
      

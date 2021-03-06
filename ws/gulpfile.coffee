gulp = require('gulp')
spawn = require('child_process').spawn
node = 0

gulp.task(
    'server'
    ->
        if node
            node.kill()
        node = spawn('node', ['ws.js'], {
            stdio: 'inherit'
        })
        node.on(
            'close'
            (code) ->
                if code == 8
                    gulp.log('Error detected, waiting for changes...')
        )
)

gulp.task(
    'default'
    ['server']
    ->

        gulp.watch(
            ['./**/*.coffee']
            ['server']
        )
)

process.on(
    'exit'
    ->
        if node
            node.kill()
)

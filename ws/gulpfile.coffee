gulp = require('gulp')
spawn = require('child_process').spawn
node

gulp.task(
    'server'
    ->
        if node
            node.kill()
            node = spawn('node', ['index.js'], {
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
    ->
        gulp.run('server')

        gulp.watch(
            ['./**.coffee']
            ->
                gulp.run('server')
        )
)

process.on(
    'exit'
    ->
        if node
            node.kill()
)

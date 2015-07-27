kit = require 'nokit'

module.exports = (task) ->

	task 'test', 'Test APIs', ->
		kit.spawn('mocha', [
			'--require', 'coffee-script/register'
			'-R', 'spec'
			'test/basic.coffee'
		]).then ({ code }) ->
			process.exit code

	task 'collision', '10 seconds collision test', ->
		kit.spawn 'coffee', [
			'test/collision.coffee'
		]
	task 'build', 'Build project', ->
		kit.spawn 'coffee', [
			'-o', 'dist'
			'-c', 'src/jhash.coffee'
		]

	task 'benchmark', 'Simple benchmark', ->
		jhash = require './src/jhash'

		path = 'test/rand_file.bin'
		buf = kit.readFileSync path
		file_size = kit.statSync(path).size

		count = 0
		start_time = Date.now()
		span = 0

		while span < 10
			if count % 1000 == 0
				span = (Date.now() - start_time) / 1000
			jhash.hash buf
			count++

		console.log """
		#{Math.round(count / span)} ops/s.
		Avr. file size #{file_size}B.
		"""

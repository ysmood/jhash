#!node_modules/.bin/coffee

_ = require 'underscore'
crypto = require 'crypto'
jhash = require '../src/jhash'

collision_test = ->
	console.log '\n=== Collision Test ==='

	hash = (mod, hash_fun) ->
		arr = []
		for i in [0 ... 500]
			arr[i] = _.random(0, 2 ** 8 - 1)

		buf = new Buffer(arr)

		md5_sum = crypto
			.createHash('md5')
			.update(buf)
			.digest('base64')

		[
			hash_fun.call mod, arr, true
			md5_sum
		]

	batch = (mod, hash_fun, name) ->
		start_time = Date.now()
		count = 0
		collision = 0
		res = {}
		while true
			v = hash(mod, hash_fun)
			if res[v[0]] and res[v[0]] != v[1]
				collision++
			else
				res[v[0]] = v[1]

			# Run about 10 seconds.
			if ++count % 100 == 0 and
			Date.now() - start_time >= 1000 * 10
				break

		time = (Date.now() - start_time) / 1000

		console.log """
			***** #{name} *****
			time: #{time}s
			collisions: #{collision / count * 100}% (#{collision} / #{count})
		"""

	batch jhash, jhash.hash, 'jhash'

collision_test()

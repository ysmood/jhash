#!nodeModules/.bin/coffee

_ = require 'underscore'
crypto = require 'crypto'
jhash = require '../src/jhash'

collisionTest = ->
	console.log '\n=== Collision Test ==='

	hash = (mod, hashFun) ->
		arr = []
		for i in [0 ... 500]
			arr[i] = _.random(0, 2 ** 8 - 1)

		buf = new Buffer(arr)

		md5Sum = crypto
			.createHash('md5')
			.update(buf)
			.digest('base64')

		[
			hashFun.call mod, arr, true
			md5Sum
		]

	batch = (mod, hashFun, name) ->
		startTime = Date.now()
		count = 0
		collision = 0
		res = {}
		while true
			v = hash(mod, hashFun)
			if res[v[0]] and res[v[0]] != v[1]
				collision++
			else
				res[v[0]] = v[1]

			# Run about 10 seconds.
			if ++count % 100 == 0 and
			Date.now() - startTime >= 1000 * 10
				break

		time = (Date.now() - startTime) / 1000

		console.log """
			***** #{name} *****
			time: #{time}s
			collisions: #{collision / count * 100}% (#{collision} / #{count})
		"""

	batch jhash, jhash.hash, 'jhash'

collisionTest()

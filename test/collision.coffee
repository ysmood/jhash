#!node_modules/.bin/coffee

_ = require 'underscore'
ys_hash = require '../src/ys_hash'

test = (hash_fun) ->
	arr = []
	for i in [0 ... _.random(1, 10000)]
		# It's hard to collision, so I decreaed the random byte value
		# from `2 ** 8` to `2 ** 3`
		arr.push _.random(0, 2 ** 8)

	hash_fun.call ys_hash, arr

batch = (hash_fun, name) ->
	start_time = Date.now()
	count = 0
	res = {}
	samples = []
	while true
		v = test(hash_fun)
		samples.push v
		res[v] = true

		# Run about 10 seconds.
		if ++count % 100 == 0 and
		Date.now() - start_time >= 1000 * 10
			break

	sample = JSON.stringify(
		samples[0...10].map (el) ->
			el.toString(36)
	)
	time = (Date.now() - start_time) / 1000
	ratio = (1 - _.size(res) / count) * 100

	console.log """
		first 10 results: #{sample}
		            time: #{time}s
		      collisions: #{ratio}% (#{count - _.size(res)}/#{count})
	"""

batch ys_hash.hash, 'hash_buffer'

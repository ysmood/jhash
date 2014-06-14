#!node_modules/.bin/coffee

_ = require 'underscore'
ys_hash = require '../src/ys_hash'
fs = require 'fs-extra'

test = (hash_fun) ->
	arr = []
	for i in [0 ... _.random(1, 10000)]
		# It's hard to collision, so I decreaed the random byte value
		# from `2 ** 8` to `2 ** 3`
		arr.push _.random(0, 2 ** 8)

	hash_fun.call ys_hash, arr

batch = (hash_fun, name) ->
	len = 10000
	time = _.now()
	res = {}
	samples = []
	for i in [0 ... len]
		v = test(hash_fun)
		samples.push v
		res[v] = true

	ratio = (1 - _.size(res) / len) * 100
	sample = JSON.stringify(
		samples[0..10].map (el) ->
			el.toString(36)
	)
	time = (_.now() - time) / 1000

	console.log """
		task count: #{len}
		10 samples: #{sample}
		      time: #{time}s
		collisions: #{ratio}% #{len - _.size(res)}
	"""

batch ys_hash.hash_arr, 'hash_buffer'


# Sample hash file hash sum.
buf = fs.readFileSync 'test/rand_file.bin'
console.log '>> Sample file: ' + ys_hash.hash(buf) # >> 1gom8fv

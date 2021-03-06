{_} = require 'nokit'

hashFuns =
	xorHash: (arr) ->
		h = 0
		for i in arr
			h ^= i
		h

	rotatingHash: (arr) ->
		h = 0
		for i in arr
			h = (h << 8 | h >>> 24) ^ i
		h

	bjbHash: (arr) ->
		h = 0
		for i in arr
			# js supports Infinity large number.
			# To avoid infinity, here we use the bit mask.
			h = (h * 33 & 0xffffffff) + i
		h

	bjb2Hash: (arr) ->
		# Typically better than the original one.
		# The result sum typically shorter then the original one.
		h = 0
		for i in arr
			h = (h * 33 & 0xffffffff) ^ i
		h

	fnvHash: (arr) ->
		###
			Follows the same lines as Bernstein's modified hash with carefully chosen constants.
		###

		h = 2166136261
		for i in arr
			h = ( h * 16777619 & 0xffffffff) ^ i
		h

	oatHash: (arr) ->
		h = 0
		for i in arr
			h += i
			h += (h << 10)
			h ^= (h >>> 6)

		h += (h << 3)
		h ^= (h >>> 11)
		h += (h << 15)

		h

	jswHash: (arr) ->
		###
			One bit cycle
		###

		h = 2 ** 24 + 335
		for i in arr
			h = (h << 1 | h >>> 31) ^ i
		h

	jhash: (arr) ->
		h = 2 ** 23 + 335
		for i in arr
			# Use the mask to keep the hash value positive.
			h = ( (h << 1 | h >>> 30) & 0x7fffffff ) ^ i
		h

test = (hashFun) ->
	arr = []
	for i in [0 ... _.random(200, 5000)]
		# It's hard to collision, so I decreaed the random byte value
		# from `2 ** 8` to `2 ** 3`
		arr.push _.random(0, 2 ** 3)

	hashFun(arr)

batch = (hashFun, name) ->
	len = 100000
	time = _.now()
	res = {}
	samples = []
	for i in [0 ... len]
		v = test(hashFun)
		samples.push v
		res[v] = true

	sample = JSON.stringify(
		samples[0..10].map (el) ->
			el.toString(36)
	)
	time = (_.now() - time) / 1000

	console.log """

		****** #{name} *******
		     sample: #{sample}
		       time: #{time}s
		 collisions: #{_.size(res)} / #{len}
	"""

for k, v of hashFuns
	batch(v, k)

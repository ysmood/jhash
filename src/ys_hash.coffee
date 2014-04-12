do ->
	# The prime number nearest to 2 ** 23.
	init_sum = 8388617

	ys_hash =
		hash_buffer: (buf) ->
			h = init_sum
			for i in buf
				# One bit cycling the hash value.
				# Use the mask to keep the hash value positive.
				h = ( (h << 1 | h >>> 30) & 0x7fffffff ) ^ i
			h.toString(36)

		hash_str: (str) ->
			h = init_sum
			i = 0
			len = str.length
			while i < len
				h = ( (h << 1 | h >>> 30) & 0x7fffffff ) ^ str.charCodeAt(i++)
			h.toString(36)

	if typeof module == 'undefined'
		window.ys_hash = ys_hash
	else
		module.exports = ys_hash

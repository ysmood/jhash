do ->
	ys_hash =
		hash_buffer: (buf) ->
			h = 2 ** 23 + 335
			for i in buf
				# One bit cycling the hash value.
				# Use the mask to keep the hash value positive.
				h = ( (h << 1 | h >>> 30) & 0x7fffffff ) ^ i
			h.toString(36)

		hash_str: (str) ->
			h = 2 ** 23 + 335
			for i in [0 ... str.length]
				h = ( (h << 1 | h >>> 30) & 0x7fffffff ) ^ str.charCodeAt(i)
			h.toString(36)

	if typeof module == 'undefined'
		window.ys_hash = ys_hash
	else
		module.exports = ys_hash

do ->
	# The prime number nearest to 2 ** 23.
	init_sum = 8388617

	to_base_str = (num, base = 70) ->
		###
			The num should be an int. The base's range is [2, 70].
		###

		# RFC 3986 URI chars without some unsafe chars "$&+,/:;=?@#~[]".
		symbols = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ-._!'()*".split('')
		str = ''
		sign = ''

		# We need to keep the number positive.
		if num < 0
			sign = '-'
			num *= -1

		while num >= base
			s = num % base
			str = symbols[s] + str
			num = (num - s) / base

		str = sign + symbols[num] + str

		return str

	ys_hash =
		hash_arr: (arr) ->
			h = init_sum
			for i in arr
				# One bit cycling the hash value.
				# Use the mask to keep the hash value positive.
				h = ( (h << 1 | h >>> 30) & 0x7fffffff ) ^ i
			to_base_str(h)

		hash_str: (str) ->
			h = init_sum
			i = 0
			len = str.length
			while i < len
				h = ( (h << 1 | h >>> 30) & 0x7fffffff ) ^ str.charCodeAt(i++)
			to_base_str(h)

	if typeof module == 'undefined'
		window.ys_hash = ys_hash
	else
		module.exports = ys_hash

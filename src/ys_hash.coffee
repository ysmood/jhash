do ->
	class Ys_hash
		constructor: ->
			# The prime number nearest to 2 ** 23.
			@init_sum = 8388617

			# RFC 3986 URI chars without some unsafe chars "$&+,/:;=?@#~[]".
			@set_symbols "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ-._!'()*"

			# The default length is 31 which will prevent negative number.
			@set_mask_len 31

		set_symbols: (str) =>
			###
				Control the char set.
			###

			@symbols = str.split('')

		set_mask_len: (len) =>
			###
				If you want shorter hash, this is the api.
			###

			@mask = 0xffffffff >>> (32 - len)

		hash_arr: (arr) =>
			###
				Also can hash a file buffer.
			###

			h = @init_sum
			for i in arr
				# One bit cycling the hash value.
				# Use the mask to keep the hash value positive.
				h = ( (h << 1 | h >>> 30) & @mask) ^ i
			@to_str(h)

		hash_str: (str) =>
			h = @init_sum
			i = 0
			len = str.length
			while i < len
				h = ( (h << 1 | h >>> 30) & @mask ) ^ str.charCodeAt(i++)
			@to_str(h)

		to_str: (num) ->
			str = ''
			sign = ''
			base = @symbols.length

			# We need to keep the number positive.
			if num < 0
				sign = '-'
				num *= -1

			while num >= base
				s = num % base
				str = @symbols[s] + str
				num = (num - s) / base

			str = sign + @symbols[num] + str

			return str

	if typeof module == 'undefined'
		window.ys_hash = new Ys_hash
	else
		module.exports = new Ys_hash

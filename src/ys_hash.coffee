do ->
	class Ys_hash
		constructor: ->
			# RFC 3986 URI chars without some unsafe chars "$&+,/:;=?@#~[]".
			@set_symbols "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ-._!'()*"

			@set_mask_len 32

		set_symbols: (str) =>
			###
				Control the char set.
			###

			@symbols = str.split('')

		set_mask_len: (len) =>
			###
				If you want shorter hash, this is the api.
			###

			len = 32 if len > 32

			@init_sum = 2 ** ((len - len % 2) / 2)

			@roll_len = len - 1

			@mask = 0xffffffff >>> (32 - len)

		hash: (data) ->
			###
				Auto check the data type and choose the corresponding method.
			###

			if typeof data == 'string'
				@hash_str data
			else if Buffer.isBuffer(data) or Arrary.isArray(data)
				@hash_arr data

		hash_arr: (arr) ->
			###
				Also can hash a file buffer.
				return a string.
			###

			h = @init_sum
			for i in arr
				# One bit cycling the hash value.
				# Use the mask to keep the hash value positive.
				h = ( (h << 1 | h >>> @roll_len) & @mask) ^ i
			@to_str(h)

		hash_str: (str) ->
			h = @init_sum
			i = 0
			len = str.length
			while i < len
				h = ( (h << 1 | h >>> @roll_len) & @mask ) ^ str.charCodeAt(i++)
			@to_str(h)

		to_str: (num) ->
			str = ''
			base = @symbols.length

			# We need to keep the number positive.
			# This way won't decrease the info.
			if @roll_len == 31
				if num < 0
					num = -2 * num - 1
				else
					num = 2 * num

			while num >= base
				s = num % base
				str = @symbols[s] + str
				num = (num - s) / base

			str = @symbols[num] + str

			return str

	if typeof module == 'undefined'
		window.ys_hash = new Ys_hash
	else
		module.exports = new Ys_hash

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

	hash: (data, is_number = false) ->
		###
			Auto check the data type and choose the corresponding method.
		###

		if typeof data == 'string'
			h = @hash_str data
		else if Buffer.isBuffer(data) or Array.isArray(data)
			h = @hash_arr data

		# Use 'n >>> 0' to prevent the negative number.
		h = h >>> 0

		if is_number
			h
		else
			@to_str h

	hash_arr: (arr) ->
		###
			Also can hash a file buffer.
		###

		h = @init_sum
		for i in arr
			h = @sum h, i
		h

	hash_str: (str) ->
		h = @init_sum
		i = 0
		len = str.length
		while i < len
			h = @sum h, str.charCodeAt(i++)
		h

	sum: (h, v) ->
		# One bit cycling the hash value.
		( (h << 1 | h >>> @roll_len) & @mask ) ^ v

	to_str: (num) ->
		str = ''
		base = @symbols.length

		while num >= base
			s = num % base
			str = @symbols[s] + str
			num = (num - s) / base

		str = @symbols[num] + str

		return str

if typeof module == 'undefined'
	window.ys_hash = new Ys_hash
else
	global.Ys_hash = Ys_hash
	module.exports = new Ys_hash

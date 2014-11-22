class Jhash
	constructor: ->
		# RFC 3986 URI chars without some unsafe chars "$&+,/:;=?@#~[]".
		@setSymbols "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ-._!'()*"

		@setMaskLen 32

	setSymbols: (str) =>
		###
			Control the char set.
		###

		@symbols = str.split('')

	setMaskLen: (len) =>
		###
			If you want shorter hash, this is the api.
		###

		len = 32 if len > 32

		@initSum = 2 ** ((len - len % 2) / 2)

		@rollLen = len - 1

		@mask = 0xffffffff >>> (32 - len)

	hash: (data, isNumber = false) ->
		###
			Auto check the data type and choose the corresponding method.
		###

		if typeof data == 'string'
			h = @hashStr data
		else if Buffer.isBuffer(data) or Array.isArray(data)
			h = @hashArr data

		# Use 'n >>> 0' to prevent the negative number.
		h = h >>> 0

		if isNumber
			h
		else
			@toStr h

	hashArr: (arr) ->
		###
			Also can hash a file buffer.
		###

		h = @initSum
		for i in arr
			h = @sum h, i
		h

	hashStr: (str) ->
		h = @initSum
		i = 0
		len = str.length
		while i < len
			h = @sum h, str.charCodeAt(i++)
		h

	sum: (h, v) ->
		# One bit cycling the hash value.
		( (h << 1 | h >>> @rollLen) & @mask ) ^ v

	toStr: (num) ->
		str = ''
		base = @symbols.length

		while num >= base
			s = num % base
			str = @symbols[s] + str
			num = (num - s) / base

		str = @symbols[num] + str

		return str

# AMD Support
if typeof module == "object" and typeof module.exports == "object"
	global.Jhash = Jhash
	module.exports = new Jhash
else
	if typeof define == "function" and define.amd
		define -> new Jhash
	else
		window.jhash = new Jhash

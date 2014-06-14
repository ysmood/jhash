
h = parseInt '11111111111111111111111111111100', 2

for i in [0...50]
	h = (h << 1 | h >>> 31 & 0xffffffff) ^ 0

	h = h >>> 0

	console.log h.toString(2)


ys = require '../src/ys_hash'

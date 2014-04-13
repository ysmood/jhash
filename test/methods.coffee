assert = require 'assert'
ys = require '../src/ys_hash'

hash_str = ->
	ys.hash_str 'asd0802kjksdf023hkdfhv'

assert.equal(hash_str(), '7L0XQ')

ys.set_symbols 'abcdefg'

assert.equal(hash_str(), 'edgeedabcd')

ys.set_mask_len 10

assert.equal(hash_str(), 'cbf')

console.log '>> All passed.'

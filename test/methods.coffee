assert = require 'assert'
jhash = require '../src/jhash'

hash_str = ->
	jhash.hash_str 'asd0802kjksdf023hkdfhv'

assert.equal(hash_str(), '7L0XQ')

jhash.set_symbols 'abcdefg'

assert.equal(hash_str(), 'edgeedabcd')

jhash.set_mask_len 10

assert.equal(hash_str(), 'cbf')

console.log '>> All passed.'

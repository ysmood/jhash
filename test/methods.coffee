assert = require 'assert'
jhash = require '../src/jhash'

hashStr = ->
	jhash.hashStr 'asd0802kjksdf023hkdfhv'

assert.equal(hashStr(), '7L0XQ')

jhash.setSymbols 'abcdefg'

assert.equal(hashStr(), 'edgeedabcd')

jhash.setMaskLen 10

assert.equal(hashStr(), 'cbf')

console.log '>> All passed.'

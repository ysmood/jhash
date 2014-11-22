jhash = require '../src/jhash'
assert = require 'assert'
fs = require 'fs'

stringTest = ->
	assert.equal jhash.hash('test'), '349o'
	assert.equal jhash.hash('1234'), '343E'
	assert.equal jhash.hash('“I like men who have a future and women who have a past.” - Oscar Wilde'), '1gmfFH'
	assert.equal jhash.hash('芝兰生于深谷，不以无人而不芳。'), '1QVoF2'
	assert.equal jhash.hash('信じることから始まるのが宗教なら、疑うことから始めるのが科学です。'), '276j!6'

arrTest = ->
	assert.equal jhash.hash([1, 2, 3, 4]), '33*M'

bufTest = ->
	buf = fs.readFileSync 'test/rand_file.bin'
	assert.equal jhash.hash(buf), '1GC3Um'

describe '# hash', ->
	it 'Should works with string', stringTest
	it 'Should works with array', arrTest
	it 'Should works with buffer', bufTest

describe '# hashStr', ->
	it 'Should works with string', stringTest

describe '# hashArr', ->
	it 'Should works with array', arrTest
	it 'Should works with buffer', bufTest

describe '# setSymbols', ->
	it 'Should works properly', ->
		jhash.setSymbols 'abc'
		assert.equal jhash.hash('test'), 'bcccaccaccacb'

describe '# setMaskLen', ->
	it 'Should works properly', ->
		jhash.setMaskLen 10
		assert.equal jhash.hash('test'), 'caabb'

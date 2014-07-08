jhash = require '../src/jhash'
assert = require 'assert'
fs = require 'fs'

string_test = ->
	assert.equal jhash.hash('test'), '349o'
	assert.equal jhash.hash('1234'), '343E'
	assert.equal jhash.hash('“I like men who have a future and women who have a past.” - Oscar Wilde'), '1gmfFH'
	assert.equal jhash.hash('芝兰生于深谷，不以无人而不芳。'), '1QVoF2'
	assert.equal jhash.hash('信じることから始まるのが宗教なら、疑うことから始めるのが科学です。'), '276j!6'

arr_test = ->
	assert.equal jhash.hash([1, 2, 3, 4]), '33*M'

buf_test = ->
	buf = fs.readFileSync 'test/rand_file.bin'
	assert.equal jhash.hash(buf), '1GC3Um'

describe '# hash', ->
	it 'Should works with string', string_test
	it 'Should works with array', arr_test
	it 'Should works with buffer', buf_test

describe '# hash_str', ->
	it 'Should works with string', string_test

describe '# hash_arr', ->
	it 'Should works with array', arr_test
	it 'Should works with buffer', buf_test

describe '# set_symbols', ->
	it 'Should works properly', ->
		jhash.set_symbols 'abc'
		assert.equal jhash.hash('test'), 'bcccaccaccacb'

describe '# set_mask_len', ->
	it 'Should works properly', ->
		jhash.set_mask_len 10
		assert.equal jhash.hash('test'), 'caabb'

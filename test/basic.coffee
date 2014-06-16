ys = require '../src/ys_hash'
assert = require 'assert'
fs = require 'fs'

string_test = ->
	assert.equal ys.hash('test'), '349o'
	assert.equal ys.hash('1234'), '343E'
	assert.equal ys.hash('“I like men who have a future and women who have a past.” - Oscar Wilde'), '1gmfFH'
	assert.equal ys.hash('芝兰生于深谷，不以无人而不芳。'), '1QVoF2'
	assert.equal ys.hash('信じることから始まるのが宗教なら、疑うことから始めるのが科学です。'), '276j!6'

arr_test = ->
	assert.equal ys.hash([1, 2, 3, 4]), '33*M'

buf_test = ->
	buf = fs.readFileSync 'test/rand_file.bin'
	assert.equal ys.hash(buf), '1GC3Um'

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
		ys = new Ys_hash
		ys.set_symbols 'abc'
		assert.equal ys.hash('test'), 'bcccaccaccacb'

describe '# set_mask_len', ->
	it 'Should works properly', ->
		ys = new Ys_hash
		ys.set_mask_len 10
		assert.equal ys.hash('test'), '2q'

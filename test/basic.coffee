jhash = require '../src/jhash'
kit = require 'nokit'
{Promise} = kit

module.exports = (it) ->
	stringTest = () ->
		Promise.all [
			it.eq jhash.hash('test'), '349o'
			it.eq jhash.hash('1234'), '343E'
			it.eq jhash.hash('“I like men who have a future and women who have a past.” - Oscar Wilde'), '1gmfFH'
			it.eq jhash.hash('芝兰生于深谷，不以无人而不芳。'), '1QVoF2'
			it.eq jhash.hash('信じることから始まるのが宗教なら、疑うことから始めるのが科学です。'), '276j!6'
		]

	arrTest = ->
		it.eq jhash.hash([1, 2, 3, 4]), '33*M'

	bufTest = ->
		buf = kit.readFileSync 'test/rand_file.bin'
		it.eq jhash.hash(buf), '1GC3Um'

	it.describe '# hash', (it) ->
		it 'Should works with string', stringTest
		it 'Should works with array', arrTest
		it 'Should works with buffer', bufTest

	it.describe '# hashStr', (it) ->
		it 'Should works with string', stringTest

	it.describe '# hashArr', (it) ->
		it 'Should works with array', arrTest
		it 'Should works with buffer', bufTest

	it.describe '# setSymbols', (it) ->
		it 'Should works properly', ->
			jhash.setSymbols 'abc'
			it.eq jhash.hash('test'), 'bcccaccaccacb'

	it.describe '# setMaskLen', (it) ->
		it 'Should works properly', ->
			jhash.setMaskLen 10
			it.eq jhash.hash('test'), 'caabb'

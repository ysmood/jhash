kit = require 'nokit'
_ = kit._

dirPath = 'randFiles'

try
	kit.removeSync dirPath

kit.mkdirSync dirPath

_.times 5, (num) ->
	len = _.random(1, 10000)
	buf = new Buffer(len)
	for i in [0 ... len]
		buf[i] = _.random(0, 2 ** 8)

	kit.outputFileSync dirPath + "/#{num}.bin", buf

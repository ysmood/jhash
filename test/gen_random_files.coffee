fs = require 'fs-extra'
_ = require 'underscore'

dirPath = 'randFiles'

try
	fs.removeSync dirPath

fs.mkdirSync dirPath

_.times 5, (num) ->
	len = _.random(1, 10000)
	buf = new Buffer(len)
	for i in [0 ... len]
		buf[i] = _.random(0, 2 ** 8)

	fs.outputFileSync dirPath + "/#{num}.bin", buf

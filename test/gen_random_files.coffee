fs = require 'fs-extra'
_ = require 'underscore'

dir_path = 'rand_files'

try
	fs.removeSync dir_path

fs.mkdirSync dir_path

_.times 5, (num) ->
	len = _.random(1, 10000)
	buf = new Buffer(len)
	for i in [0 ... len]
		buf[i] = _.random(0, 2 ** 8)

	fs.outputFileSync dir_path + "/#{num}.bin", buf

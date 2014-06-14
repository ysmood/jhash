commander = require 'commander'

default_symbols = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

commander
.usage '[options] [file_path or string]'
.option '-s, --string', 'Do not treat arg as file path'
.option '-l, --symbols <chars>', "Control the hash char set. Default is #{default_symbols}"
.option '-m, --mask <int>', 'Control the max length of the result hash value. Unit is bit. Default is 32'
.option '-v, --ver', 'Print version'
.parse process.argv

if commander.ver
	conf = require '../package'
	console.log 'v' + conf.version
	process.exit()

data = commander.args[0]
if data
	fs = require 'fs'
	if not commander.string and fs.existsSync(data) and fs.statSync(data).isFile()
		data = fs.readFileSync data

	ys = require __dirname + '/../dist/ys_hash'

	if commander.symbols
		ys.set_symbols commander.symbols
	else
		ys.set_symbols default_symbols

	if commander.mask
		ys.set_mask_len +commander.mask

	console.log ys.hash(data)

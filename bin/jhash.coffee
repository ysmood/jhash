commander = require 'commander'

default_symbols = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

commander
.usage '[options] [file_path or string]'
.option '-s, --string', 'Do not treat arg as file path.'
.option '-l, --symbols <chars>', "Control the hash char set. Default is '#{default_symbols}'."
.option '-f, --full', "Force to use full char set. It will override the '-l'."
.option '-m, --mask <int>', 'Control the max length of the result hash value. Unit is bit. Default is 32.'
.option '-v, --ver', 'Print version.'
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

	jhash = require __dirname + '/../dist/jhash'

	if not commander.full
		if commander.symbols
			jhash.set_symbols commander.symbols
		else
			jhash.set_symbols default_symbols

	if commander.mask
		jhash.set_mask_len +commander.mask

	console.log jhash.hash(data)
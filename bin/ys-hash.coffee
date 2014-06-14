fs = require 'fs'
ys = require __dirname + '/../dist/ys_hash'
commander = require 'commander'

commander
.usage '[file_path or string]'
.option '-s, --string', 'Do not treat arg as file path'
.option '-v, --ver', 'Print version'
.parse process.argv

if commander.ver
	conf = require '../package'
	console.log 'v' + conf.version
	process.exit()

data = commander.args[0]
if data
	if not commander.string and fs.existsSync(data) and fs.statSync(data).isFile()
		data = fs.readFileSync data

	console.log ys.hash(data)

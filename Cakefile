require 'coffee-script/register'
fs = require 'fs'
{ spawn } = require 'child_process'

get_right_bin = (cmd) ->
	if process.platform == 'win32'
		win_cmd = cmd + '.cmd'
		if fs.existsSync win_cmd
			cmd = win_cmd
		else if not fs.existsSync cmd
			cmd = which.sync(cmd)
	return cmd

coffee_bin = get_right_bin 'node_modules/.bin/coffee'

task 'build', 'Build project', ->
	spawn coffee_bin, [
		'-o', 'dist'
		'-c', 'src/ys_hash.coffee'
	], {
		stdio: 'inherit'
	}

	p = spawn coffee_bin, [
		'-c', 'bin'
	], {
		stdio: 'inherit'
	}

	p.on 'close', ->
		cmd = '#!/usr/bin/env node\n'
		path = 'bin/ys-hash.js'
		data = fs.readFileSync path, 'utf8'
		data = cmd + data
		fs.writeFileSync path, data

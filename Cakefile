fs = require 'fs'
{ spawn } = require 'child_process'

task 'test', 'Test APIs', ->
	spawn 'mocha', [
		'--require', 'coffee-script/register'
		'test/basic.coffee'
	], {
		stdio: 'inherit'
	}

task 'collision', '10 seconds collision test', ->
	spawn 'coffee', [
		'test/collision.coffee'
	], {
		stdio: 'inherit'
	}

task 'build', 'Build project', ->
	spawn 'coffee', [
		'-o', 'dist'
		'-c', 'src/ys_hash.coffee'
	], {
		stdio: 'inherit'
	}

	p = spawn 'coffee', [
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

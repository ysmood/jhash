fs = require 'fs'
spawn = require 'win-spawn'

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

task 'benchmark', 'Simple benchmark', ->
	require 'coffee-script/register'
	_ = require 'underscore'
	ys = require './src/ys_hash'

	count = 10000
	start_time = Date.now()
	file = fs.readFileSync('test/rand_file.bin')
	_.times count, ->
		ys.hash file

	span = (Date.now() - start_time) / 1000
	console.log """
	Run for #{count} files.
	Takes #{span}s"""

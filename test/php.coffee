jhash = require '../src/jhash'
fs = require 'fs'

jhash.set_symbols '0123456789abcdefghijklmnopqrstuvwxyz'

data = fs.readFileSync('test/rand_file.bin')

console.log jhash.hash(data)

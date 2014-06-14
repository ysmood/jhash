ys = require '../src/ys_hash'
fs = require 'fs'

ys.set_symbols '0123456789abcdefghijklmnopqrstuvwxyz'

data = fs.readFileSync('test/rand_file.bin')

console.log ys.hash(data)

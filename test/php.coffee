jhash = require '../src/jhash'
fs = require 'fs'

jhash.setSymbols '0123456789abcdefghijklmnopqrstuvwxyz'

data = fs.readFileSync('test/randFile.bin')

console.log jhash.hash(data)

require 'math'

function basen(n, b)
	n = math.floor(n)
	if not b or b == 10 then return tostring(n) end
	digits = "0123456789abcdefghijklmnopqrstuvwxyz"
	t = {}
	sign = ""
	if n < 0 then
		sign = "-"
		n = -n
	end
	repeat
		d = (n % b) + 1
		n = math.floor(n / b)
		table.insert(t, 1, digits:sub(d,d))
	until n == 0
	return sign .. table.concat(t,"")
end

function ys_hash(arr)
	h = 8388617
	for k, v in pairs(arr) do
		h = bit32.bxor(
			bit32.band(
				bit32.bor(
					bit32.lshift(h, 1),
					bit32.rshift(h, 30)
				),
				0x7fffffff
			),
			v
		)
	end
	return basen(h, 36)
end

arr = {}
for i = 1, 5000 do
	arr[i] = math.random(0, 255)
end

print(ys_hash(arr))
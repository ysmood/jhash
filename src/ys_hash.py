import random

def baseN(num,b,numerals="0123456789abcdefghijklmnopqrstuvwxyz"):
    return ((num == 0) and numerals[0]) or (baseN(num // b, b, numerals).lstrip(numerals[0]) + numerals[num % b])

def ys_hash(arr):
	h = reduce(
		lambda sum, n:
			((sum << 1 | sum >> 31) & 0xffffffff) ^ n,
		arr,
		8388617
	)
	return baseN(h, 36)

# Test
arr = map(
	lambda n:
		random.randint(0, 2 ** 8),
	range(5000)
)
print ys_hash(arr)
#include "stdio.h"

unsigned ys_hash (void *key, int len) {
	unsigned char *p = key;
	unsigned h = 8388617;

	for (int i = 0; i < len; ++i)
	{
		h = ( (h << 1 | h >> 30) & 0x7fffffff ) ^ p[i];
	}
	return h;
}

int main(int argc, char const *argv[])
{
	int arr[] = { 12, 0, 23, 43, 230, 2 };

	printf("%d\n", ys_hash(arr, 3));

	return 0;
}

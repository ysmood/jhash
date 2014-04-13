package main

import (
	"fmt"
	"math/rand"
	"strconv"
	"time"
)

func ys_hash(arr []int32) string {
	var h int32 = 8388617
	l := len(arr)
	for i := 0; i < l; i++ {
		h = ((h<<1 | h>>30) & 0x7fffffff) ^ arr[i]
	}
	return strconv.FormatInt(
		int64(h), 36,
	)
}

func main() {
	// Make test array.
	arr := make([]int32, 5000)
	rand.Seed(time.Now().Unix())
	for i := 0; i < 5000; i++ {
		arr[i] = rand.Int31n(256)
	}

	fmt.Println(ys_hash(arr))
}

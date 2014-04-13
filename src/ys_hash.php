<?

function ys_hash($arr) {
	$h = array_reduce(
		$arr,
		function($sum, $n) {
			return ( ($sum << 1 | $sum >> 30) & 0x7fffffff ) ^ $n;
		},
		8388617
	);

	return base_convert($h, 10, 36);
}

// Test
$arr = array();
for ($i = 0; $i < 5000; $i++) {
	$arr[$i] = rand(0, 255);
}

echo ys_hash($arr) . "\n";

?>
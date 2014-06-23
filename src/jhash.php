<?

function jhash($str) {
	$arr = str_split($str);

	$h = array_reduce(
		$arr,
		function($sum, $n) {
			return ( ($sum << 1 | $sum >> 31) & 0xffffffff ) ^ ord($n);
		},
		65536
	);

	return base_convert($h, 10, 36);
}

$data = file_get_contents('test/rand_file.bin');

echo jhash($data);

?>
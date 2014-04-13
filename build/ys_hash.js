// Generated by CoffeeScript 1.7.1
(function() {
  var init_sum, ys_hash;
  init_sum = 8388617;
  ys_hash = {
    hash_arr: function(arr) {
      var h, i, _i, _len;
      h = init_sum;
      for (_i = 0, _len = arr.length; _i < _len; _i++) {
        i = arr[_i];
        h = ((h << 1 | h >>> 30) & 0x7fffffff) ^ i;
      }
      return h.toString(36);
    },
    hash_str: function(str) {
      var h, i, len;
      h = init_sum;
      i = 0;
      len = str.length;
      while (i < len) {
        h = ((h << 1 | h >>> 30) & 0x7fffffff) ^ str.charCodeAt(i++);
      }
      return h.toString(36);
    }
  };
  if (typeof module === 'undefined') {
    return window.ys_hash = ys_hash;
  } else {
    return module.exports = ys_hash;
  }
})();
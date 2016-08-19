module.exports = function (str) {
    var h = 8388617;
    for (var i = 0; i < str.length; i++)
    {
        h = ( (h << 1 | h >>> 30) & 0xffffffff ) ^ str.charCodeAt(i);
    }
    return h;
};

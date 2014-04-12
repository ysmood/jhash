## YS Hash

A fast algorithm to hash string or binary file inspired by the JSW hash.
Not likes md5 or sha1, the hash sum it creates is only about 6 chars.
Useful when using in the url and middle scale table lookup.

## Implementations

### coffee

#### Node

* install

 ```shell
 npm install ys-hash
 ```

* Use in code

 ```javascript
 var ys = require('ys-hash');
 ys.hash_str('test'); // output => '27wvh2'
 
 var fs = require('fs');
 ys.hash_buffer(fs.readFileSync('a.jpg'));
 ```

#### Browser

```html
<script src='ys_hash.js'></script>
<script>
  ys_hash.hash_str('test'); // output => '27wvh2'
</script>
```

## Road Map

* Add some test cases.

* Implement into other languages.

## The MIT License (MIT)

Apr 2014 ys

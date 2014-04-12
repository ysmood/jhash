## YS Hash

A fast algorithm to hash string or binary file inspired by the JSW hash.
Not likes md5 or sha1, the hash sum it creates is only about 6 chars.

Useful when using it in the **URL** or **table lookup**.

## Implementations

### coffee

#### Node

* Install

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

Download the js file from the release page: [Release][1].

```html
<script src='ys_hash.js'></script>
<script>
  ys_hash.hash_str('test'); // output => '27wvh2'
</script>
```

## Test

### Random Test

    task count: 10000
    10 samples: ["ezsb1p","qb4990","roc6b8","ayxqrb","2a9u7v","xiizm1","1dpjti","n57f2y","6lcshz","g883np","41431w"]
          time: 1.319s
    collisions: 0%

## Road Map

* Add some test cases.

* Implement into other languages.

## The MIT License (MIT)

Apr 2014 ys


  [1]: https://github.com/ysmood/ys-hash/releases

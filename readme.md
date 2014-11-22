## Overview

A fast algorithm to hash string or binary file inspired by the JSW hash.
Not likes md5 or sha1, the hash sum it creates is only about 6 chars (if you use base 70).

I used it in one of my company's node project.
It helps me peacefully distribute different versions of files to the CDN service.

Useful when using it in the **URL** hash or **table lookup**.

[![Build Status](https://travis-ci.org/ysmood/jhash.svg)](https://travis-ci.org/ysmood/jhash) [![Build status](https://ci.appveyor.com/api/projects/status/tsh8f5680c5esiqr)](https://ci.appveyor.com/project/ysmood/jhash)

## Features

* Easy to control the length of the result hash value.

* Lite and fast.


## Other Language Implementations

I have implemented the core algorithm into 7 commonly used languages:

* c
* coffeescript
* go
* lua
* php
* python
* ruby

Only the coffeescript one has full API.


### Node

* Install

 ```shell
 npm install jhash
 ```

* Usage

 ```javascript
 var jhash = require('jhash');
 jhash.hash('test'); // output => '349o'

 var fs = require('fs');
 jhash.hash(fs.readFileSync('a.jpg'));

 // Control the hash char set.
 jhash.setSymbols('abcdef');
 jhash.hash('test'); // output => 'decfddfe'

 // Control the max length of the result hash value. Unit is bit.
 jhash.setMaskLen(10);
 jhash.hash('test'); // output => 'ede'
 ```

### Browser

Install it via [Bower][2]: `bower install jhash`.

Or download the js file from the release page: [Release][1].

```html
<script src='jhash.js'></script>
<script>
  jhash.hash('test'); // output => '349o'
</script>
```


### CLI Tool

* Install

  To use it as a command line tool, install it globally.

      npm install -g jhash

* Usage

  Here are some examples.

  Print help information:

        jhash -h

  Hash string `abc`, it outputs `2csX`:

        jhash abc

  Hash a jpg image file (it will automatically detect whether the passed in argument is a file or not):

        jhash a.jpg

## Test

#### Unit test

You must have installed [coffeescript](https://github.com/ysmood/jdb/blob/master/coffeescript.org) and [mocha](http://visionmedia.github.io/mocha/) globally.

    cake test

#### Collision test for 10 seconds random data

    cake collision

#### Compare to some other hash algorithms

This is just a random test, you may need to test some real data before using it in project.

```
****** jhash *******
     sample: ["jg0ayq","nz9fb0","oa9iz1","4w5egf","dt7dsv","9wkm25","duu2j2","solh6y","z6rnbl","aa8ebp","g568a2"]
       time: 6.836s
 collisions: 0.000999999999995449%

****** rotating_hash *******
     sample: ["ahuz3","2hxrf3","k68zy","3cdf61","2857v2","fgua","3216o4","2i69dz","1ehpfn","1y46pv","3m1r0h"]
       time: 7.154s
 collisions: 48.626000000000005%

****** bjb2_hash *******
     sample: ["sdflvy","-g2j5ix","-1dsjyy","sezbl2","-wye5kw","-bdfy0t","-mudsaj","-4f3shn","-z1mxsl","-165mmr","q5oh58"]
       time: 16.718s
 collisions: 0.002000000000002%

****** fnv_hash *******
     sample: ["4ct07k","-pdrz0h","me11fv","t9px7i","-y120s","251qw7","h83axv","tob69f","eonk6","-6dkeny","elxam6"]
       time: 16.787s
 collisions: 0.000999999999995449%

****** oat_hash *******
     sample: ["-fg1gqa","-2k0tg","a391j2","1jd98xw","2dw8oj","-uldzx3","-t9m4me","-5z57og","6m0uqx","-17q8t0j","u8m0lo"]
       time: 19.028s
 collisions: 0.000999999999995449%

****** jsw_hash *******
     sample: ["-hm4rfv","vehfuu","jwf2v0","5c2oq3","-9xs2xt","p1ho2c","-ri84uf","op47br","-13wvwp","ek12tv","hrc6ki"]
       time: 15.702s
 collisions: 0.002999999999997449%
```


## Benchmark

Run `cake benchmark`.

Intel Core i7 2.3GHz SSD

    87174 ops/s.
    Avr. file size 6716B.


## Road Map

* Add more test cases.


## The MIT License (MIT)

Apr 2014 jhash


  [1]: https://github.com/ysmood/jhash/releases
  [2]: https://github.com/bower/bower

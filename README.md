# Metalbird - Library for Publishing posts

[![Build Status](https://travis-ci.org/hubtee/metalbird.svg)](https://travis-ci.org/hubtee/metalbird)
[![Coverage Status](https://coveralls.io/repos/hubtee/metalbird/badge.svg)](https://coveralls.io/r/hubtee/metalbird)
[![Code Climate](https://codeclimate.com/github/hubtee/metalbird/badges/gpa.svg)](https://codeclimate.com/github/hubtee/metalbird)
[![Inline docs](http://inch-ci.org/github/hubtee/metalbird.svg?branch=master)](http://inch-ci.org/github/hubtee/metalbird)
[![Dependency Status](https://gemnasium.com/hubtee/metalbird.svg)](https://gemnasium.com/hubtee/metalbird)
[![Yard Docs](http://img.shields.io/badge/yard-docs-blue.svg)](http://www.rubydoc.info/github/hubtee/metalbird/master)

## Install

```sh
$ gem install metalbird
```

```ruby
gem 'metalbird'
```

## Usage

### Twitter

```ruby
require 'metalbird'

opts = {}
opts[:consumer_key] = ENV['TWITTER_CONSUMER_KEY']
opts[:consumer_secret] = ENV['TWITTER_CONSUMER_SECRET']
opts[:access_token] = ENV['ACCESS_TOKEN']
opts[:access_token_secret] = ENV['ACCESS_TOKEN_SECRET']

auth = Metalbird::Twitter::Authentication.new(opts)
publisher = Metalbird::Twitter::Publisher.new(auth)

# Post tweet
args = Metalbird::Twitter::PublishArgs.new(tweet: 'Hello, World')
publisher.publish(args)

# Post tweet with images
data = {
  tweet: 'Hello, image',
  images: [File.open('./images/image.jpg')]
}
args = Metalbird::Twitter::PublishArgs.new(data)
publisher.publish(args)

# Retweet
args = Metalbird::Twitter::RetweetArgs.new(tweet_id: 645198939356983296)
publisher.publish(args)
```

### Tumblr

## Support

### Web Service

* [ ] Hubtee Front
* [x] Twitter
* [ ] Facebook Page
* [ ] Google+
* [ ] Kakao
* [ ] Linkedin

### Blog

* [x] Tumblr
* [ ] Naver Blog
* [ ] TatterTools
* [ ] Qiita
* [ ] Ghost
* [ ] Midium
* [ ] Daum blog api
* [ ] Blogger
* [ ] SVBTLE

### CMS

* [ ] Wordpress
* [ ] Zeroboard XE
* [ ] Dupral
* [ ] Joolma
* [ ] Naver Cafe
* [ ] Daum Cafe

### Storage

* [ ] S3 

### etc

* [ ] Github Page
* [ ] Gist
* [ ] Mailgun(Email)
* [ ] Evernote
* [ ] Pocket
* [ ] Reddit
* [ ] Delicious
* [ ] WebHook

## Contributors

* Daekwon Kim (nacyot)

## License

The MIT License (MIT)

Copyright (c) 2015 Daekwon Kim

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use, copy,
modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
DEALINGS IN THE SOFTWARE.

require 'dotenv'

require './lib/metalbird'

Dotenv.load

prosseor = Metalbird::UrlProcessor::Bitly.new(api_key: ENV['BITLY_API_KEY'])
puts prosseor.generate('https://github.com/nacyot')
# puts prosseor.expand('http://bit.ly/1NLH8zy')

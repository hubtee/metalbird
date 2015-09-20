require 'dotenv'

require './lib/metalbird'

Dotenv.load

prosseor = Metalbird::UrlProcessor::Google.new(api_key: ENV['GOOGLE_API_KEY'])
puts prosseor.generate('https://github.com/nacyot')

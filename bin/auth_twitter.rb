#!/usr/bin/env ruby

require './lib/metalbird/authenticators/twitter.rb'

url = 'https://api.twitter.com'
authenticator = Metalbird::Authenticator::Twitter.new(url)
authenticator.authenticate

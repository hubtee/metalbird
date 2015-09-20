#!/usr/bin/env ruby

require './lib/metalbird/authenticators/google.rb'

authenticator = Metalbird::Authenticator::Google.new
authenticator.authenticate

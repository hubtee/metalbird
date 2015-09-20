require './lib/metalbird'
require 'pp'

Dotenv.load

opts = {}
opts[:consumer_key] = ENV['TWITTER_CONSUMER_KEY']
opts[:consumer_secret] = ENV['TWITTER_CONSUMER_SECRET']
opts[:access_token] = ENV['ACCESS_TOKEN']
opts[:access_token_secret] = ENV['ACCESS_TOKEN_SECRET']

auth = Metalbird::Twitter::Authentication.new(opts)
publisher = Metalbird::Twitter::Publisher.new(auth)

args = Metalbird::Twitter::PublishArgs.new(tweet: 'Hello, World')
pp publisher.publish(args)

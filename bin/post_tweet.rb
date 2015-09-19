require './lib/post_publisher'
require 'pp'

Dotenv::Railtie.load

opts = {}
opts[:consumer_key] = ENV['TWITTER_CONSUMER_KEY']
opts[:consumer_secret] = ENV['TWITTER_CONSUMER_SECRET']
opts[:access_token] = ENV['ACCESS_TOKEN']
opts[:access_token_secret] = ENV['ACCESS_TOKEN_SECRET']

auth = PostPublisher::Twitter::Authentication.new(opts)
publisher = PostPublisher::Twitter::Publisher.new(auth)

args = PostPublisher::Twitter::PublishArgs.new(tweet: 'Hello, World')
pp publisher.publish(args)

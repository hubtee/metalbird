require 'post_publisher'
require 'logger'
require 'coveralls'
Coveralls.wear!

PostPublisher::Logger.level = Logger::FATAL

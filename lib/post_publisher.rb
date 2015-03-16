$LOAD_PATH.unshift File.dirname(__FILE__)

module PostPublisher
  autoload :Twitter, 'post_publisher/twitter'
  autoload :Tumblr, 'post_publisher/tumblr'
end

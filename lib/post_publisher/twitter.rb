module PostPublisher
  module Twitter
    autoload :Authentication, 'post_publisher/twitter/authentication'
    autoload :Publisher, 'post_publisher/twitter/publisher'
    autoload :PublishArgs, 'post_publisher/twitter/publish_args'
    autoload :RetweetArgs, 'post_publisher/twitter/retweet_args'
  end
end

module PostPublisher
  module Twitter
    autoload :Authentication, 'post_publisher/twitter/authentication'
    autoload :Publisher, 'post_publisher/twitter/publisher'
    autoload :CliTools, 'post_publisher/twitter/cli_tools'
  end
end

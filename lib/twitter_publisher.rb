$LOAD_PATH.unshift File.dirname(__FILE__)

module TwitterPublisher
  autoload :Authentication, 'twitter_publisher/authentication'
  autoload :Publisher, 'twitter_publisher/publisher'
  autoload :CliTools, 'twitter_publisher/cli_tools'
end

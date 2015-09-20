require 'logger'

$LOAD_PATH.unshift File.dirname(__FILE__)

module Metalbird
  autoload :Twitter, 'metalbird/twitter'
  autoload :Tumblr, 'metalbird/tumblr'
  autoload :Authenticator, 'metalbird/authenticator'

  Logger = ::Logger.new(STDOUT)
end

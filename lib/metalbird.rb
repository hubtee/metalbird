require 'logger'

$LOAD_PATH.unshift File.dirname(__FILE__)

module Metalbird
  autoload :Twitter, 'metalbird/twitter'
  autoload :Tumblr, 'metalbird/tumblr'

  Logger = ::Logger.new(STDOUT)
end

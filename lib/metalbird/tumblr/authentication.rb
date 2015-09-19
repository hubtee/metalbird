require 'tumblr_client'

module Metalbird
  module Tumblr
    class Authentication
      attr_reader :client

      def initialize(opts = {})
        validate_opts(opts)

        ::Tumblr.configure do |config|
          config.consumer_key = opts[:consumer_key]
          config.consumer_secret = opts[:consumer_secret]
          config.oauth_token = opts[:oauth_token]
          config.oauth_token_secret = opts[:oauth_token_secret]
        end

        @client = ::Tumblr::Client.new
      end

      def validate_opts(opts)
        if !opts[:consumer_key] ||
           !opts[:consumer_secret] ||
           !opts[:oauth_token] ||
           !opts[:oauth_token_secret]
        
          fail ArgumentError
        end
      end
    end
  end
end

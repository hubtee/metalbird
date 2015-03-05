require 'twitter'

module PostPublisher
  module Twitter
    class Authentication
      attr_reader :client

      def initialize(opts = {})
        validate_opts(opts)

        @client = ::Twitter::REST::Client.new do |config|
          config.consumer_key = opts[:consumer_key]
          config.consumer_secret = opts[:consumer_secret]
          config.access_token = opts[:access_token]
          config.access_token_secret = opts[:access_token_secret]
        end
      end

      def validate_opts(opts)
        if !opts[:consumer_key] ||
           !opts[:consumer_secret] ||
           !opts[:access_token] ||
           !opts[:access_token_secret]

          fail ArgumentError
        end
      end
    end
  end
end

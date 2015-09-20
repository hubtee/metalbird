require 'googl'

module Metalbird
  module UrlProcessor
    class Google
      RETRY_LIMIT = 3

      attr_reader :client

      def initialize(opts)
        @client = Googl
        @key = opts[:api_key]
      end

      def generate(link)
        retry_counter ||= 0
        Googl.shorten(link, nil, @key).short_url
      rescue => error
        Metalbird::Logger.error(error)
        retry_counter += 1
        retry if retry_counter <= RETRY_LIMIT
        raise URLShortenFailError
      end

      def expand(shorten_link)
        retry_counter ||=  0
        Googl.expand(shorten_link, key: @key).long_url
      rescue => error
        Metalbird::Logger.error(error)
        retry_counter += 1
        retry if retry_counter <= RETRY_LIMIT
        raise URLExpandFailError
      end
    end

    class URLShortenFailError < StandardError; end
    class URLExpandFailError < StandardError; end
  end
end

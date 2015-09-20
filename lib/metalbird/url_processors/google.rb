require 'googl'

module Metalbird
  module UrlProcessor
    class Google
      attr_reader :client

      def initialize(api_key)
        @client = Googl
        @key = api_key
      end

      def generate(link)
        Googl.shorten(link, nil, @key).short_url
      rescue => error
        Metalbird::Logger.error(error)
        raise URLShortenFailError
      end

      def expand(shorten_link)
        Googl.expand(shorten_link, key: @key).long_url
      rescue => error
        Metalbird::Logger.error(error)
        raise URLExpandFailError
      end
    end

    class URLShortenFailError < StandardError; end
    class URLExpandFailError < StandardError; end
  end
end

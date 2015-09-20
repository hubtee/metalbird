require 'bitly'

Bitly.use_api_version_3

module Metalbird
  module UrlProcessor
    class Bitly
      RETRY_LIMIT = 3

      attr_reader :client

      def initialize(opts)
        ::Bitly.configure do |config|
          config.api_version = 3
          config.access_token = opts[:api_key]
        end

        @client = ::Bitly.client
      end

      def generate(link)
        retry_counter ||= 0
        @client.shorten(link).short_url
      rescue => error
        Metalbird::Logger.error(error)
        retry_counter += 1
        retry if retry_counter <= RETRY_LIMIT
        raise URLShortenFailError
      end

      def expand(shorten_link)
        retry_counter ||= 0
        @client.expand(shorten_link).long_url
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

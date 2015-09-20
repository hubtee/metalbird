# See http://d.hatena.ne.jp/riocampos+tech/20130615/p1
require 'oauth'

module Metalbird
  module Authenticator
    class Twitter
      @consumer_key = ''
      @consumer_secret = ''
      @access_token = ''
      @accent_token_secret = ''

      def initialize(oauth_url)
        @oauth_url = oauth_url
      end

      def authenticate
        set_consumer_keys
        set_access_tokens
        puts_authentication_information
      end

      private

      def set_consumer_keys
        puts "Set your consumer_key: "
        @consumer_key = gets.chomp

        puts "Set your consumer_secret: "
        @consumer_secret = gets.chomp
      end

      def get_oauth
        OAuth::Consumer.new(
          @consumer_key,
          @consumer_secret,
          site: @oauth_url
        )
      end

      def set_access_tokens
        oauth = get_oauth
        request_token = oauth.get_request_token

        puts "Access below URL: \n#{request_token.authorize_url}"
        puts "Enter your PIN code: "
        pin = gets.chomp

        tokens = request_token.get_access_token(oauth_verifier: pin)
        @access_token = tokens.token
        @access_token_secret = tokens.secret
      end

      def puts_authentication_information
        puts "consumer_key:        #{@consumer_key}"
        puts "consumer_secret:     #{@consumer_secret}"
        puts "access_token:        #{@access_token}"
        puts "access_token_secret: #{@access_token_secret}"
      end
    end
  end
end

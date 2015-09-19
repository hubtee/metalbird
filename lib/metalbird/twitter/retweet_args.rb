module Metalbird
  module Twitter
    class RetweetArgs
      attr_reader :tweet_id

      def initialize(data)
        fail NoTweetIDError unless data[:tweet_id]
        @tweet_id = data[:tweet_id]
      end
    end

    class NoTweetIDError < StandardError; end
  end
end

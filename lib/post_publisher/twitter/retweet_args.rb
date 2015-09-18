module PostPublisher
  module Twitter
    class RetweetArgs
      attr_reader :tweet_id

      def initialize(data)
        @tweet_id = data[:tweet_id]
      end
    end
  end
end

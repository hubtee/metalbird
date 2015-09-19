module PostPublisher
  module Twitter
    class Publisher
      def initialize(auth)
        @client = auth.client
      end

      def publish(args)
        @client.update(args.tweet)
      rescue => error
        PostPublisher::Logger.error(error)
        return false
      end

      def retweet(args)
        tweet = ::Twitter::Tweet.new(id: args.tweet_id)
        @client.retweet(tweet)
      rescue => error
        PostPublisher::Logger.error(error)
        return false
      end
    end
  end
end

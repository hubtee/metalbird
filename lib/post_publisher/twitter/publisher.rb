module PostPublisher
  module Twitter
    class Publisher
      def initialize(auth)
        @client = auth.client
      end

      def publish(args)
        result = @client.update(args.tweet)

        {
          content: args.tweet,
          id: result.id
        }

      rescue => error
        puts error
      end

      def retweet(args)
        tweet = ::Twitter::Tweet.new(id: args.tweet_id)
        @client.retweet(tweet)
      rescue => error
        puts error
      end
    end
  end
end

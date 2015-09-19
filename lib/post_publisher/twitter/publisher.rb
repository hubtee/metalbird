module PostPublisher
  module Twitter
    class Publisher
      def initialize(auth)
        @client = auth.client
      end

      def publish(args)
        fail NotValidArgsError unless args.validate?

        options = {}
        options[:media_ids] = upload_images(args.images) if args.images?
        @client.update(args.tweet, options)
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

      private

      def upload_images(images)
        images.map { |image| upload(image) }.join(',')
      end

      def upload(file)
        @client.upload(file)
      rescue => error
        PostPublisher::Logger.error(error)
        return false
      end
    end

    class NotValidArgsError < StandardError; end
  end
end

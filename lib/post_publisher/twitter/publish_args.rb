require 'twitter-text'

module PostPublisher
  module Twitter
    class PublishArgs
      MAX_TWEET_LENGTH = 140
      IMAGE_LENGTH = 23
      LINK_LENGTH = 23
      MAX_LINK_COUNT = 4
      MAX_IMAGE_COUNT = 4

      attr_reader :tweet, :links, :images

      def initialize(data)
        fail NoTweetError unless data[:tweet]

        analyzed_tweet = analyze_tweet(data[:tweet])

        @tweet = analyzed_tweet[:tweet]
        @links = (data[:links] || []) + analyzed_tweet[:links]
        @images = data[:images] || []
      end

      def validate?
        validate_not_empty &&
          validate_image_count &&
          validate_link_count &&
          validate_length
      end

      def images?
        true if @images.length > 0
      end

      def links?
        true if @links.length > 0
      end

      def image_count
        images.length
      end

      def link_count
        links.length
      end

      private

      def validate_not_empty
        @tweet != ''
      end

      def validate_length
        @tweet.length <= max_length 
      end

      def validate_image_count
        image_count <= MAX_IMAGE_COUNT
      end

      def validate_link_count
        link_count <= MAX_LINK_COUNT
      end

      def analyze_tweet(tweet)
        urls = ::Twitter::Extractor.extract_urls(tweet)
        ::Twitter::Extractor.extract_urls_with_indices(tweet).each do |url|
          tweet.slice!(*url[:indices])
        end

        {
          tweet: tweet.strip,
          links: urls
        }
      end

      def max_length
        case
        when images? && links?
          return MAX_TWEET_LENGTH - IMAGE_LENGTH - LINK_LENGTH * link_count
        when images? && !links?
          return MAX_TWEET_LENGTH - IMAGE_LENGTH
        when !images? && links?
          return MAX_TWEET_LENGTH - LINK_LENGTH * link_count
        else
          return MAX_TWEET_LENGTH
        end
      end
    end

    class NoTweetError < StandardError; end
  end
end

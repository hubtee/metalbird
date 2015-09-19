require 'twitter-text'
require 'uri'

module Metalbird
  module Twitter
    class PublishArgs
      MAX_TWEET_LENGTH = 140
      IMAGE_LENGTH = 23
      LINK_LENGTH = 23
      MAX_LINK_COUNT = 4
      MAX_IMAGE_COUNT = 4

      attr_reader :links, :images, :errors

      def initialize(data)
        fail NoTweetError unless data[:tweet]

        analyzed_tweet = analyze_tweet(data[:tweet])

        @tweet = analyzed_tweet[:tweet]
        @links = ((data[:links] || []) + analyzed_tweet[:links]).uniq
        @images = data[:images] || []
        @errors = []
      end

      def tweet
        return @tweet.strip + ' ' + links.join(' ') if links?
        @tweet
      end

      def validate?
        @errors = []

        validate_not_empty &&
          validate_image_count &&
          validate_link_count &&
          validate_length &&
          validate_images &&
          validate_links
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
        is_valid = @tweet != ''
        return true if is_valid
        @errors << EmptyTweetError.new
        false
      end

      def validate_length
        length = @tweet.length
        is_valid = length <= max_length
        return true if is_valid
        @errors << ExceedTweetLengthLimitError.new(length: length)
        false
      end

      def validate_images
        is_valid = @images.all? do |image|
          image.class.ancestors.include?(IO)
        end

        return true if is_valid
        @errors << NotValidImageError.new
        false
      end

      def validate_links
        is_valid = @links.all? do |link|
          link =~ URI::regexp
        end

        return true if is_valid
        @errors << NotValidLinkError.new
        false
      end

      def validate_image_count
        is_valid = image_count <= MAX_IMAGE_COUNT
        return true if is_valid
        @errors << ExceedImageCountLimitError.new(count: image_count)
        false
      end

      def validate_link_count
        is_valid = link_count <= MAX_LINK_COUNT
        return true if is_valid
        @errors << ExceedLinkCountLimitError.new(count: link_count)
        false
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
    class EmptyTweetError < OpenStruct; end
    class ExceedTweetLengthLimitError < OpenStruct; end
    class NotValidImageError < OpenStruct; end
    class NotValidLinkError < OpenStruct; end
    class ExceedImageCountLimitError < OpenStruct; end
    class ExceedLinkCountLimitError < OpenStruct; end
  end
end

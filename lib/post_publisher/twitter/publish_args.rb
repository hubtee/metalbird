module PostPublisher
  module Twitter
    class PublishArgs
      attr_reader :tweet

      def initialize(data)
        @tweet = data[:tweet]
      end
    end
  end
end

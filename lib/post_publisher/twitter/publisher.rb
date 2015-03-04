module PostPublisher
  class Publisher
    def initialize(auth)
      @client = auth.client
    end

    def publish(tweet)
      result = @client.update(tweet)

      {
        content: tweet,
        id: result.id
      }

    rescue => error
      # Twitter::Error::Forbidden
      puts error
    end
  end
end

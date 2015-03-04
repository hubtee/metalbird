require 'spec_helper'

describe PostPublisher::Twitter::Publisher do
  let(:auth) do
    opts = {}
    opts[:consumer_key] = ''
    opts[:consumer_secret] = ''
    opts[:access_token] = ''
    opts[:access_token_secret] = ''

    PostPublisher::Twitter::Authentication.new(opts)
  end

  let(:tweet){'Hello, world!'}
  
  describe 'publish' do
    specify 'Publish return tweet object' do
      publisher = PostPublisher::Twitter::Publisher.new(auth)
      allow(publisher).to receive(:publish) { Twitter::Tweet.new(id: 0) }

      result = publisher.publish(tweet)
      expect(result).to be_an_instance_of(Twitter::Tweet)
    end

    it 'raise Forbidden error when publishing failed' do
      publisher = PostPublisher::Twitter::Publisher.new(auth)
      allow(publisher).to receive(:publish) do
        raise Twitter::Error::Forbidden
      end

      expect do
        publisher.publish(tweet)
      end.to raise_error(Twitter::Error::Forbidden)
    end
  end
end

require 'spec_helper'

describe PostPublisher::Twitter::Publisher do
  let(:auth) do
    double('PostPublisher::Twitter::Authentication', client: double())
  end

  let(:tweet_text) { 'Hello, world!' }
  let(:tweet_id) { 12345 }
  let(:tweet) { Twitter::Tweet.new(id: tweet_id) }

  let(:publish_args) do
    PostPublisher::Twitter::PublishArgs.new(tweet: tweet_text)
  end

  let(:retweet_args) do
    PostPublisher::Twitter::RetweetArgs.new(tweet_id: tweet_id)
  end

  describe '#publish' do
    describe 'Success' do
      it 'send update message to client' do
        expect(auth.client).to receive(:update).with(tweet_text)
        PostPublisher::Twitter::Publisher.new(auth).publish(publish_args)
      end
    end

    describe 'Fail' do
      it 'return false when publishing failed' do
        allow(auth.client).to receive(:update).with(tweet_text).and_raise
        publisher = PostPublisher::Twitter::Publisher.new(auth)
        expect(publisher.publish(publish_args)).to equal(false)
      end
    end
  end

  describe 'retweet' do
    describe 'Success' do
      it 'send retweet message to client' do
        expect(auth.client).to receive(:retweet).with(tweet)
        PostPublisher::Twitter::Publisher.new(auth).retweet(retweet_args)
      end
    end

    describe 'Fail' do
      it 'return false when retweet failed' do
        allow(auth.client).to receive(:rewteet).with(tweet_id).and_raise
        publisher = PostPublisher::Twitter::Publisher.new(auth)
        expect(publisher.publish(retweet_args)).to equal(false)
      end
    end
  end
end

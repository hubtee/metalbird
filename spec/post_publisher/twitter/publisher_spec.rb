require 'spec_helper'

module Metalbird
  module Twitter
    describe Publisher do
      let(:auth) do
        double('Metalbird::Twitter::Authentication', client: double())
      end

      let(:tweet_text) { 'Hello, world!' }
      let(:tweet_id) { 1234 }
      let(:tweet) { ::Twitter::Tweet.new(id: tweet_id) }
      let(:publish_args) { PublishArgs.new(tweet: tweet_text) }
      let(:retweet_args) { RetweetArgs.new(tweet_id: tweet_id) }

      let(:publish_args_with_images) do
        options = {
          tweet: tweet_text,
          images: [double('File', class: File), double('File', class: File)]
        }
        PublishArgs.new(options)
      end

      describe '#publish' do
        describe 'Success' do
          it 'send update message to client' do
            expect(auth.client).to receive(:update).with(tweet_text, {})
            Publisher.new(auth).publish(publish_args)
          end

          it 'send upload message when images attached' do
            publisher = Publisher.new(auth)
            expect(publisher).to receive(:upload).exactly(2).times
            allow(auth.client).to receive(:update)
            publisher.publish(publish_args_with_images)
          end
        end

        describe 'Fail' do
          it 'return false when publishing failed' do
            allow(auth.client).to receive(:update).with(tweet_text, {}).and_raise
            publisher = Publisher.new(auth)
            expect(publisher.publish(publish_args)).to equal(false)
          end
        end
      end

      describe 'retweet' do
        describe 'Success' do
          it 'send retweet message to client' do
            expect(auth.client).to receive(:retweet).with(tweet)
            Publisher.new(auth).retweet(retweet_args)
          end
        end

        describe 'Fail' do
          it 'return false when retweet failed' do
            allow(auth.client).to receive(:rewteet).with(tweet_id).and_raise
            publisher = Publisher.new(auth)
            expect(publisher.publish(retweet_args)).to equal(false)
          end
        end
      end
    end
  end
end

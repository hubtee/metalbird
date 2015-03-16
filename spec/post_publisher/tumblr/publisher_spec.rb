require 'spec_helper'

describe PostPublisher::Tumblr::Publisher do
  let(:auth) do
    opts = {}
    opts[:consumer_key] = ''
    opts[:consumer_secret] = ''
    opts[:oauth_token] = ''
    opts[:oauth_token_secret] = ''

    PostPublisher::Tumblr::Authentication.new(opts)
  end

  let(:blog_name){ 'rtsolv.tumblr.com' }
  let(:post){ { title: 'Hello, world!', body: 'Hello tumblr!' } }
  
  describe 'publish' do
    specify 'Publish return hash' do
      publisher = PostPublisher::Tumblr::Publisher.new(auth)
      allow(publisher).to receive(:publish) { { content: post, id: 0 } }

      result = publisher.publish(blog_name, post)
      expect(result).to be_an_instance_of(Hash)
    end

    it 'raise error when publishing failed' do
      publisher = PostPublisher::Tumblr::Publisher.new(auth)
      allow(publisher).to receive(:publish) do
        raise
      end

      expect do
        publisher.publish(blog_name, post)
      end.to raise_error(RuntimeError)
    end
  end
end

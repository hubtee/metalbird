require 'spec_helper'

describe PostPublisher::Tumblr::Authentication do
  let(:opts) do
    opts = {}
    opts[:consumer_key] = ''
    opts[:consumer_secret] = ''
    opts[:access_token] = ''
    opts[:access_token_secret] = ''

    opts
  end

  describe 'Initialize - Opts validate' do
    it 'is fail when there isn\'t authentication key' do
      expect do
        PostPublisher::Tumblr::Authentication.new({})
      end.to raise_error(ArgumentError)
    end

#    it 'is success when there are all authentication keys' do
#      expect do
#        PostPublisher::Twitter::Authentication.new(opts)
#      end.to_not raise_error
#    end
  end

#  describe 'Initialize' do
#    let(:auth) do
#      PostPublisher::Twitter::Authentication.new(opts)
#    end
#    
#    it 'is set client object' do
#      expect(auth.client).to_not be_nil
#    end
#
#    specify 'Client object is a Twitter::Rest::Client instance' do
#      expect(auth.client).to be_kind_of(Twitter::REST::Client)
#    end
#  end
end

require 'spec_helper'

describe Metalbird::Twitter::RetweetArgs do
  subject { Metalbird::Twitter::RetweetArgs }

  let(:tweet_id) { 1234 }
  let(:basic_args) { subject.new(tweet_id: tweet_id) }

  describe '#initialize' do
    it "raise NoTweetError when there isn't tweet body" do
      expect do
        subject.new({})
      end.to raise_error(Metalbird::Twitter::NoTweetIDError)
    end

    it 'has attribute readers' do
      expect(basic_args).to respond_to(:tweet_id)
    end
  end
end

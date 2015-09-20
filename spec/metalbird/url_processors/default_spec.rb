require 'spec_helper'

module Metalbird
  module UrlProcessor
    describe Default do
      subject { Default.new }
      let(:url) { 'http://github.com/nacyot' }

      describe '#generate' do
        it 'returns the param' do
          expect(subject.generate(url)).to be_equal(url)
        end
      end

      describe '#expand' do
        it 'returns the param' do
          expect(subject.expand(url)).to be_equal(url)
        end
      end
    end
  end
end

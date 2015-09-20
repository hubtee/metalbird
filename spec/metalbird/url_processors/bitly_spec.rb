require 'googl'
require 'spec_helper'

module Metalbird
  module UrlProcessor
    describe Bitly do
      let(:api_key) { 'this_is_api_key' }
      let(:bitly) { Bitly.new(api_key: api_key) }
      let(:url) { 'http://github.com/nacyot' }
      let(:shorten_url) { 'https://goo.gl/abcd' }
      let(:shorten_object) { double(nil, short_url: shorten_url) }
      let(:expanded_object) { double(nil, long_url: url) }

      describe '#generate' do
        context 'success' do
          it 'returns shorten url' do
            allow(bitly.client).to receive(:shorten).and_return(shorten_object)
            expect(bitly.generate(url)).to be_eql(shorten_url)
          end

          it 'retry and return shorten url when request failed.' do
            allow(bitly.client).to(receive(:shorten)
                             .and_raise(StandardError)
                             .and_return(shorten_object))
            expect(bitly.generate(url)).to be_eql(shorten_url)
          end
        end

        context 'fail' do
          it 'raise URLShortenFailError' do
            allow(bitly.client).to receive(:shorten).and_raise(StandardError)
            expect { bitly.generate(url) }.to raise_error(URLShortenFailError)
          end
        end
      end

      describe '#expand' do
        context 'success' do
          it 'returns long url' do
            allow(bitly.client).to receive(:expand).and_return(expanded_object)
            expect(bitly.expand(url)).to be_eql(url)
          end

          it 'retry and return expanded url when request failed.' do
            allow(bitly.client).to(receive(:expand)
                             .and_raise(StandardError)
                             .and_return(expanded_object))
            expect(bitly.expand(url)).to be_eql(url)
          end
        end

        context 'fail' do
          it 'raise URLExpandFailError' do
            allow(bitly.client).to receive(:expand).and_raise(StandardError)
            expect { bitly.expand(url) }.to raise_error(URLExpandFailError)
          end
        end
      end
    end
  end
end
require 'googl'
require 'spec_helper'

module Metalbird
  module UrlProcessor
    describe Bitly do
      let(:api_key) { 'this_is_api_key' }
      let(:bitly) { Bitly.new(api_key: api_key) }
      let(:url) { 'http://github.com/nacyot' }
      let(:shorten_url) { 'https://goo.gl/abcd' }
      let(:shorten_object) { double(nil, short_url: shorten_url) }
      let(:expanded_object) { double(nil, long_url: url) }

      describe '#generate' do
        context 'success' do
          it 'returns shorten url' do
            allow(bitly.client).to receive(:shorten).and_return(shorten_object)
            expect(bitly.generate(url)).to be_eql(shorten_url)
          end

          it 'retry and return shorten url when request failed.' do
            allow(bitly.client).to(receive(:shorten)
                             .and_raise(StandardError)
                             .and_return(shorten_object))
            expect(bitly.generate(url)).to be_eql(shorten_url)
          end
        end

        context 'fail' do
          it 'raise URLShortenFailError' do
            allow(bitly.client).to receive(:shorten).and_raise(StandardError)
            expect { bitly.generate(url) }.to raise_error(URLShortenFailError)
          end
        end
      end

      describe '#expand' do
        context 'success' do
          it 'returns long url' do
            allow(bitly.client).to receive(:expand).and_return(expanded_object)
            expect(bitly.expand(url)).to be_eql(url)
          end

          it 'retry and return expanded url when request failed.' do
            allow(bitly.client).to(receive(:expand)
                             .and_raise(StandardError)
                             .and_return(expanded_object))
            expect(bitly.expand(url)).to be_eql(url)
          end
        end

        context 'fail' do
          it 'raise URLExpandFailError' do
            allow(bitly.client).to receive(:expand).and_raise(StandardError)
            expect { bitly.expand(url) }.to raise_error(URLExpandFailError)
          end
        end
      end
    end
  end
end

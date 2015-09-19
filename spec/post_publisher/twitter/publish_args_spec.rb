require 'spec_helper'

describe Metalbird::Twitter::PublishArgs do
  subject { Metalbird::Twitter::PublishArgs }

  let(:tweet) { 'Hello, world!' }
  let(:basic_args) { subject.new(tweet: tweet) }
  let(:empty_args) { subject.new(tweet: '') }
  let(:image_file) { double('File', class: File) }

  def link(i)
    "http://example#{i}.com"
  end

  let(:images_args) do
    data = {
      tweet: tweet,
      images: [image_file, image_file]
    }

    subject.new(data)
  end

  let(:links_args) do
    subject.new(
      tweet: tweet,
      links: ['https://test.com', 'https://nacyot.com']
    )
  end

  let(:links_images_args) do
    subject.new(
      tweet: tweet,
      images: [image_file, image_file],
      links: ['https://test.com', 'https://nacyot.com']
    )
  end

  describe '#initialize' do
    it "raise NoTweetError when there isn't tweet body" do
      expect do
        subject.new({})
      end.to raise_error(Metalbird::Twitter::NoTweetError)
    end

    it "'s links has empty when links param is empty" do
      expect(basic_args.links).to be_empty
    end

    it "'s images has empty when links param is empty" do
      expect(basic_args.images).to be_empty
    end

    it 'has attribute readers' do
      expect(basic_args).to respond_to(:tweet)
      expect(basic_args).to respond_to(:links)
      expect(basic_args).to respond_to(:images)
    end
  end

  describe '#validate?' do
    context 'not empty' do
      it 'returns true when tweet is not empty' do
        expect(basic_args.validate?).to be_truthy
      end

      it 'returns false when tweet is empty' do
        expect(empty_args.validate?).to be_falsey
      end
    end

    context 'image_count' do
      it "returns true when there isn't image" do
        expect(basic_args.validate?).to be_truthy
      end

      it 'returns true when there are four images' do
        count = subject::MAX_IMAGE_COUNT
        data = { tweet: tweet, images: Array.new(count) { image_file } }
        expect(subject.new(data).validate?).to be_truthy
      end

      it 'returns false when there are more than four images' do
        count = subject::MAX_IMAGE_COUNT + 1
        data = { tweet: tweet, images: Array.new(count) { image_file } }
        expect(subject.new(data).validate?).to be_falsey
      end
    end

    context 'link_count' do
      it "returns true when there isn't link" do
        expect(basic_args.validate?).to be_truthy
      end

      it 'returns true when there are four links' do
        count = subject::MAX_LINK_COUNT
        data = { tweet: tweet, links: Array.new(count) { |i| link(i) } }
        expect(subject.new(data).validate?).to be_truthy
      end

      it 'returns false when there are more than four links' do
        count = subject::MAX_LINK_COUNT + 1
        data = { tweet: tweet, links: Array.new(count) { |i| link(i) } }
        expect(subject.new(data).validate?).to be_falsey
      end
    end

    context 'images are IO objects' do
      it 'returns true when images are IO objects' do
        expect(images_args.validate?).to be_truthy
      end

      it "returns false when images aren't IO objects" do
        data = { tweet: tweet, images: ['STRING'] }
        expect(subject.new(data).validate?).to be_falsey
      end
    end

    context 'link is valid' do
      it 'returns true when links are valid link' do
        expect(links_args.validate?).to be_truthy
      end

      it 'retruns false when links is not valid link' do
        data = { tweet: tweet, links: ['INVALID_LINK'] }
        expect(subject.new(data).validate?).to be_falsey
      end
    end

    context 'max_length' do
      context 'no images and no links' do
        it 'returns true when the tweet is 140 char' do
          data = { tweet: 'a' * 140 }
          expect(subject.new(data).validate?).to be_truthy
        end

        it 'returns true when the tweet is 141 char' do
          data = { tweet: 'a' * 141 }
          expect(subject.new(data).validate?).to be_falsey
        end
      end

      context 'images and no links' do
        it 'returns true when the tweet is 117 char' do
          data = { tweet: 'a' * 117, images: [image_file] }
          expect(subject.new(data).validate?).to be_truthy
        end

        it 'returns false when the tweet is 118 char' do
          data = { tweet: 'a' * 118, images: [image_file] }
          expect(subject.new(data).validate?).to be_falsey
        end
      end

      context 'no images and 1 links' do
        it 'returns true when the tweet is 117 char' do
          data = { tweet: 'a' * 117, links: ['https://test.com'] }
          expect(subject.new(data).validate?).to be_truthy
        end

        it 'returns false when the tweet is 118 char' do
          data = { tweet: 'a' * 118, links: ['https://test.com'] }
          expect(subject.new(data).validate?).to be_falsey
        end
      end

      context 'no images and 2 links' do
        it 'returns true when the tweet is 94 char' do
          data = { tweet: 'a' * 94, links: ['https://test.com'] }
          expect(subject.new(data).validate?).to be_truthy
        end

        it 'returns false when the tweet is 95 char' do
          data = { tweet: 'a' * 95, links: [link(1), link(2)] }
          expect(subject.new(data).validate?).to be_falsey
        end
      end

      context '1 images and 1 links' do
        it 'returns true when the tweet is 94 char' do
          data = {
            tweet: 'a' * 94,
            images: [image_file],
            links: ['https://test.com']
          }
          expect(subject.new(data).validate?).to be_truthy
        end

        it 'returns false when the tweet is 95 char' do
          data = {
            tweet: 'a' * 95,
            images: ['IMAGES'],
            links: ['https://test.com']
          }
          expect(subject.new(data).validate?).to be_falsey
        end
      end
    end
  end

  describe '#images?' do
    it 'is true when there are images' do
      expect(images_args.images?).to be_truthy
    end

    it "is false when there isn't image" do
      expect(basic_args.images?).to be_falsey
    end
  end

  describe '#links?' do
    it 'is true when there are links' do
      expect(links_args.links?).to be_truthy
    end

    it "is false when there isn't link" do
      expect(basic_args.links?).to be_falsey
    end
  end

  describe '#image_count' do
    it 'is length of images attribute' do
      expect(images_args.image_count).to be_equal(2)
      expect(basic_args.image_count).to be_equal(0)
    end
  end

  describe '#link_count' do
    it 'is length of links attribute' do
      expect(links_args.link_count).to be_equal(2)
      expect(basic_args.link_count).to be_equal(0)
    end
  end
end

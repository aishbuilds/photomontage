require 'photomontage'
require 'flickr'

describe Flickr do
	describe '#search' do
		context 'when invoked with a valid keyword,' do
			it "call the Flickr search API, and return a true value" do
				flickr = Flickr.new("apple", 1)
				expect(flickr.search).to_not eq(false)
			end
		end

		context 'when invoked with an empty string,' do
			it "call the Flickr search API, and return a false value" do
				flickr = Flickr.new("", 1)
				expect(flickr.search).to eq(false)
			end
		end
	end

	describe '#fetch' do
		context 'when invoked with a valid keyword,' do
			it "call the Flickr search API, and return an image" do
				flickr = Flickr.new("apple", 1)
				flickr.search
				expect(flickr.fetch).to be_kind_of(Magick::Image) 
			end
		end
		context 'when invoked with an invalid keyword,' do
			it "return false" do
				flickr = Flickr.new("", 1)
				flickr.search
				expect(flickr.fetch).to eq(false) 
			end
		end
	end

	describe '.create_collage' do
		context 'create a collage' do
			it "and return the resultant image" do
				allow(Flickr).to receive(:read_bg_image)
				expect(Flickr).to receive(:loop_images)
				expect(Flickr).to receive(:write_image_to_file)
				res = Flickr.create_collage("test_file")
			end
		end
	end
end
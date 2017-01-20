require 'photomontage'

describe Picturesque do
	describe '.respond' do
		context 'when no keywords are passed' do
			it "should return No keyword passed message" do
				expect(Picturesque.respond("")).to eq("No keyword passed")
			end
		end
	end
end
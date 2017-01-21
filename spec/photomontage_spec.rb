require 'photomontage'

describe Photomontage do
	describe '.begin' do
		context 'when no keywords are entered' do
			it "should return empty array" do
				words = ["exit"]
				words.each{|word| expect(STDIN).to receive(:gets).and_return(word)}
				expect(Photomontage.begin).to eq([])
			end
		end

		context 'when 3 keywords are entered' do
			it "should return array of the entered keywords" do
				words = ["penguin", "banana", "limousine", "exit"]
				words.each{|word| expect(STDIN).to receive(:gets).and_return(word)}
				expect(Photomontage.begin).to eq(words - ["exit"])
			end
		end

		context 'when 10 keywords are entered' do
			it "should return array of all entered keywords" do
				words = ["penguin", "banana", "limousine", "ocean", "game of thrones", "lion", "soccer", "boat", "exit"]
				words.each{|word| expect(STDIN).to receive(:gets).and_return(word)}
				expect(Photomontage.begin).to eq(words - ["exit"])
			end
		end
	end
end
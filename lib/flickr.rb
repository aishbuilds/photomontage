class Flickr
	include HTTParty
	base_uri 'https://api.flickr.com'
	IMAGE_WIDTH = 200
	IMAGE_HEIGHT = 300
	NO_IMAGES = 10
	PROGRESSBAR = ProgressBar.create

	def initialize(keyword, index)
		call_progress_bar
		@options = 
			{ query: 
				{
					method: 'flickr.photos.search',
					text: keyword,
					sort: 'interestingness-asc',
					nojsoncallback: 1,
					api_key: '38f8b5be4529ce3f039a5d9b94f360cd',
					per_page: 1
				}
			}
		@index = index
		@keyword = keyword
	end

	def search	
		response = self.class.get("/services/rest", @options)
		if response["rsp"]["stat"] == "ok"
			result = set_image_url(response)
			result ? result : false
		else
			return false
		end
	end

	def fetch
		File.open("tmp/#{@index}.jpg", "wb") do |f| 
			image = f.write HTTParty.get(@url).parsed_response
		end
		image = Magick::ImageList.new("tmp/#{@index}.jpg").resize_to_fill!(IMAGE_WIDTH, IMAGE_HEIGHT)
		image.write("tmp/#{@index}.jpg")
	end

	def self.create_collage(file_name)
		result  = MiniMagick::Image.new("bg.jpg")
		i,y=0,0
		(0..1).each do |j|
			x = -200
			5.times{
				img = MiniMagick::Image.new("tmp/#{i}.jpg")
				result = result.composite(img) do |c|
				c.compose "Over"
				x += 200
				i += 1
				c.geometry "+#{x}+#{y}"
				end
			}
		y += 300
		end
		result.write "images/#{file_name}.jpg"
	end

	private

	def set_image_url(response)
		photo = response["rsp"]["photos"]["photo"]
		return false unless photo
		@url = "http://farm#{photo['farm']}.staticflickr.com/#{photo['server']}/#{photo['id']}_#{photo['secret']}.jpg"
	end

	def call_progress_bar
		5.times{PROGRESSBAR.increment; sleep 0.01}
	end
end
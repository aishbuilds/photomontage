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
		@url = nil
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
		return false unless @url
		File.open("tmp/#{@index}.jpg", "wb") do |f| 
			image = f.write HTTParty.get(@url).parsed_response
		end
		image = Magick::ImageList.new("tmp/#{@index}.jpg").resize_to_fill!(IMAGE_WIDTH, IMAGE_HEIGHT)
		image.write("tmp/#{@index}.jpg")
	end

	def self.create_collage(file_name)
		bg_image = read_bg_image
		result = loop_images(bg_image)
		
		write_image_to_file(result, file_name)
	end

	private

	def self.write_image_to_file(result, file_name)
		Dir.mkdir 'images' unless File.exists?('images')
		result.write "images/#{file_name}.jpg"
	end

	def self.loop_images(result)
		@i,@y=0,0
		(0..1).each do |j|
			@x = -200
			5.times{
				img = MiniMagick::Image.new("tmp/#{@i}.jpg")
				result = make_composite_image(result, img)
			}
			@y += 300
		end
		result
	end

	def self.make_composite_image(result, img)
		result = result.composite(img) do |c|
			c.compose "Over"
			@x += 200
			@i += 1
			c.geometry "+#{@x}+#{@y}"
		end
	end

	def set_image_url(response)
		photo = response["rsp"]["photos"]["photo"]
		return false unless photo
		@url = "http://farm#{photo['farm']}.staticflickr.com/#{photo['server']}/#{photo['id']}_#{photo['secret']}.jpg"
	end

	def call_progress_bar
		5.times{PROGRESSBAR.increment; sleep 0.01}
	end

	def self.read_bg_image
		File.open("tmp/bg.jpg", "wb") do |f| 
			f.write HTTParty.get("https://s30.postimg.org/l9fwb3to1/image.jpg").parsed_response
		end
		MiniMagick::Image.new("tmp/bg.jpg")
	end
end
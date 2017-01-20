#!/usr/bin/env ruby
require "photomontage/version"
require 'httparty'
require "mini_magick"
require "rmagick"
require 'ruby-progressbar'
require 'flickr'
require 'colorize'

module Photomontage
  def self.begin
		puts "Hi there! Welcome to".green + " Photomontage!!".bold.green + "\nSimply provide 10 or less words, and get a collage of pictures representing your words, in seconds!\n".green
		puts "Type".green + " 'exit' ".red + "anytime to stop providing words \n".green
		keywords = []
		10.times{
			word = STDIN.gets.chomp
			break if word == 'exit'
			keywords << word
		}
		respond(keywords)
	end

	def self.respond(keywords)
		Dir.mkdir 'tmp' unless File.exists?('tmp')
		FileUtils.rm_rf(Dir.glob('tmp/*'))
		puts "\nHold on...While we make your collage...\n".green

		keywords.each_with_index do |keyword, index|
			scrape_flickr(keyword, index)
		end
		verify_images_present?
		puts "\n\nGreat! Your photo collage is ready! What would you like to name it?".yellow
		file_name = STDIN.gets.chomp
		Flickr.create_collage(file_name)
		FileUtils.rm_rf(Dir.glob('tmp/*'))
		puts "\n\nDone! Type".green + " 'open images/#{file_name}.jpg' ".magenta + "to view your image now! \n*If you using ruby interactive shell, exit from the shell.".green
	end

	private

	def self.scrape_flickr(keyword, index)
		flickr = Flickr.new(keyword, index)
		result = flickr.search
		flickr.fetch if result
	end

	def self.verify_images_present?
		(0..9).each do |i|
			file = "tmp/#{i}.jpg"
			unless File.exist?(file)
				while !File.exist?(file)
					result = pick_random_word(i)
				end
			end
		end
	end

	def self.pick_random_word(i)
		dictionary = File.read('/usr/share/dict/words').split("\n")
		random_word = dictionary.sample
		scrape_flickr(random_word, i)
	end
end

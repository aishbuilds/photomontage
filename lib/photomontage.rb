#!/usr/bin/env ruby
require "photomontage/version"
require 'httparty'
require "mini_magick"
require "rmagick"
require 'ruby-progressbar'
require 'flickr'
require 'colorize'
require './config/interaction'

module Photomontage
  def self.begin
		puts Interaction::WELCOME
		keywords = []
		10.times{
			word = STDIN.gets.chomp
			break if word == 'exit'
			keywords << word if !word.empty?
		}
		keywords
	end

	def self.respond(keywords)
		Dir.mkdir 'tmp' unless File.exists?('tmp')
		FileUtils.rm_rf(Dir.glob('tmp/*'))
		puts Interaction::IN_PROGRESS

		keywords.each_with_index do |keyword, index|
			scrape_flickr(keyword, index)
		end
		verify_images_present?
		puts Interaction::FILE_NAME
		file_name = STDIN.gets.chomp
		Flickr.create_collage(file_name)
		FileUtils.rm_rf(Dir.glob('tmp/*'))
		puts Interaction::COMPLETE.gsub('FILE_NAME', file_name)
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

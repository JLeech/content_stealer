require 'nokogiri'
require 'open-uri'
require_relative 'watched_saver'
require_relative 'picture_saver'

class Mdk

	FOLDER = "./mdk"
	COEFFICIENT = 10000
	HTML = "http://vk.com/onlyorly"

	attr_accessor :news

	def refresh_news
		#data= [[picture_url,news_description,views,news_link],...]
		@news = []
		page = Nokogiri::HTML(open(HTML))
		puts page.css("div.vk_wrap").count
	end

	def generate_html
		Helper.new.render_to_html(self.class)
	end

end



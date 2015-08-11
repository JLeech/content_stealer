require 'nokogiri'
require 'open-uri'
require_relative 'watched_saver'
require_relative 'picture_saver'

class Lookatme

	FOLDER = "./lookatme"
	COEFFICIENT = 10000
	HTML = "http://www.lookatme.ru/"

	attr_accessor :news

	def refresh_news
		#data= [[picture_url,news_description,views,news_link],...]
		@news = []
		page = Nokogiri::HTML(open(HTML))
		page.css("div.post-group").each do |news_block|
			featured_block = news_block.css("div.featured")
			unless featured_block.css("img")[0].nil?
				news_name = featured_block.css("img")[0]["title"]
				picture_url = featured_block.css("img")[0]["data-original"]
				news_url = HTML + featured_block.css("a")[0]["href"].sub("/","")
				views = featured_block.css("li.meta-views-counter").css("a")[0].text.to_i
				@news << [picture_url,news_name,views,news_url,Time.now]
			end
		end
		Helper.process_saving(@news, self.class)
	end

	def generate_html
		Helper.new.render_to_html(self.class)
	end

end



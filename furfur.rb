require 'nokogiri'
require 'open-uri'
require_relative 'watched_saver'
require_relative 'picture_saver'

class Furfur

	FOLDER = "./furfur"
	COEFFICIENT = 0
	HTML = "http://furfur.me"

	attr_accessor :news

	def refresh_news
		#data= [[picture_url,news_description,views,news_link],...]
		@news = []
		page = Nokogiri::HTML(open(HTML))
		page.css("div.superfeatured").each do |news_block|
			news_url = HTML+news_block.css("a.post-link")[0]["href"]
			news_name = news_block.css("h1.article-title").text
			picture_url = news_block.css("img")[0]["data-original"]
			views = news_block.css("li.meta-views-counter").text.to_i
			@news << [picture_url,news_name,views,news_url,Time.now]
		end
		page.css("div.featured").each do |news_block|
			news_url = HTML+news_block.css("a.post-link")[0]["href"]
			news_name = news_block.css("h2.post-title").text
			picture_url = news_block.css("img")[0]["data-original"]
			views = news_block.css("li.meta-views-counter").text.to_i
			@news << [picture_url,news_name,views,news_url,Time.now]
		end
		Helper.process_saving(@news, self.class)
	end

	def generate_html
		Helper.new.render_to_html(self.class)
	end

end



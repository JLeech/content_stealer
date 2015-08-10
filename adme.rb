require 'nokogiri'
require 'open-uri'
require_relative 'watched_saver'
require_relative 'picture_saver'

class Adme

	FOLDER = "./adme"
	COEFFICIENT = 200000
	HTML = "http://www.adme.ru/"

	attr_accessor :news

	def refresh_news
		#data= [[picture_url,news_description,views,news_link],...]
		@news = []
		page = Nokogiri::HTML(open(HTML))
		page.css("li.article-list-block").each do |news_block|
			views = news_block.css("li.al-stats-views").css("a")[0].text.to_i
			if views > COEFFICIENT
				news_name = news_block.css("h3.al-title").css("a")[0].text
				picture_url = news_block.css("img.al-pic")[0]["src"]
				news_url = HTML+news_block.css("a")[0]["href"].gsub("/","")
				@news << [picture_url,news_name,views,news_url,Time.now]
			end
		end
		Helper.process_saving(@news, self.class)
	end

	def generate_html
		Helper.new.render_to_html(self.class)
	end

end



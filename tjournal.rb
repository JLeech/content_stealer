require 'nokogiri'
require 'open-uri'
require_relative 'watched_saver'
require_relative 'picture_saver'

class Tjournal

	FOLDER = "./tjournal"
	COEFFICIENT = 7000
	HTML = "https://tjournal.ru/paper"

	attr_accessor :news

	def refresh_news
		#data= [[picture_url,news_description,views,news_link],...]
		@news = []
		page = Nokogiri::HTML(open(HTML))
		page.css("div.b-articles__b").each do |news_block|
			views = news_block.css("span.b-articles-info__visits")[0].text.gsub(" ","").to_i
			if views > COEFFICIENT
				news_name = news_block.css("a")[0].text.strip
				news_url = news_block.css("a")[0]["href"]
				picture_url = news_block.css("img")[0]["src"]
				@news << [picture_url,news_name,views,news_url,Time.now]
			end
		end
		Helper.process_saving(@news, self.class)
	end

	def generate_html
		Helper.new.render_to_html(self.class)
	end

end



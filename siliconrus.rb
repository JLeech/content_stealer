require 'nokogiri'
require 'open-uri'
require_relative 'watched_saver'
require_relative 'picture_saver'

class Siliconrus

	FOLDER = "./siliconrus"
	COEFFICIENT = 5000
	HTML = "http://siliconrus.com/"

	attr_accessor :news

	def refresh_news
		#data= [[picture_url,news_description,views,news_link],...]
		@news = []
		page = Nokogiri::HTML(open(HTML))
		page.css("div.masonry-item").each do |news_block|
			info_visits = news_block.css("span.b-articles-info__visits").text.gsub(" ","").to_i
			if info_visits > COEFFICIENT
				news_name = news_block.css("a.b-articles__b__name").text
				news_url = news_block.css("a.b-articles__b__name")[0]["href"]
				picture_url = news_block.css("img.b-articles__b__img__i")[0]["src"]
				@news << [picture_url,news_name,info_visits,news_url,Time.now]
			end
		end
		Helper.process_saving(@news, self.class)
	end

	def generate_html
		Helper.new.render_to_html(self.class)
	end

end



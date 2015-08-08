require 'nokogiri'
require 'open-uri'
require_relative 'watched_saver'
require_relative 'picture_saver'

class Ninegag

	FOLDER = "./ninegag"
	COEFFICIENT = 1000
	HTML = "http://9gag.com/"

	attr_accessor :news

	def refresh_news
		#data= [[picture_url,news_description,views,news_link],...]
		@news = []
		page = Nokogiri::HTML(open(HTML))
		page.css("article.badge-entry-container").each do |news_block|
			points = news_block.css("span.badge-item-love-count").text.gsub(/(,|\s)/,"").to_i
			if points > 10000
				news_name = news_block.css("header").css("a.badge-evt").text.strip
				unless news_block.css("img.badge-item-img").empty?
					picture_url = news_block.css("img.badge-item-img")[0]["src"]
					news_link = news_block["data-entry-url"]
					@news << [picture_url,news_name,points, news_link]
				end
			end
		end
		Helper.process_saving(@news, self.class)
	end

	def generate_html
		Helper.new.render_to_html(self.class)
	end

end



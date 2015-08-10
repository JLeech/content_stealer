require 'nokogiri'
require 'open-uri'
require_relative 'watched_saver'
require_relative 'picture_saver'

class Pikabu

	FOLDER = "./pikabu"
	COEFFICIENT = 2000
	HTML = "http://pikabu.ru/"

	attr_accessor :news

	def refresh_news
		#data= [[picture_url,news_description,views,news_link],...]
		@news = []
		page = Nokogiri::HTML(open(HTML))
		page.css("table.b-story").each do |news_block|
			points = news_block.css("li.b-rating__count").text.strip.to_i
			if points > COEFFICIENT
				news_name = news_block.css("a.b-story__link").text.strip
				news_link = news_block.css("a.b-story__link")[0]["href"]
				picture_url = news_block.css("table.pg")[0]["lang"] 
				unless picture_url =~ /(gif$|jpg$|png$)/
					next if picture_url.empty? && !news_block.css("div.b-story__content_type_text")[0].to_s.empty?
					raw_picture_url = news_block.css("div.b-video__preview")[0]["style"]
					picture_url = format_picture_url(raw_picture_url)
				end
				@news << [picture_url,news_name,points, news_link]
			end
		end
		Helper.process_saving(@news, self.class)
	end

	def format_picture_url(picture_url)
		extracted_picture_url = picture_url[/\(\'.*\'\)/].gsub("\(\'","").gsub("\'\)","")
	end

	def generate_html
		Helper.new.render_to_html(self.class)
	end

end



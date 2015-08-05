require_relative "watched_saver"
require_relative 'helper'

class PictureSaver

	def save(data,site)
		#data= [[picture_url,news_description,views, news_link],...]
		db = Helper.get_db(site)
		pic_folder = get_pic_folder(site)
		Dir.mkdir(pic_folder) unless File.exist?(pic_folder)
		data.each do |block|
			pic_url = block[0] 
			pic_name = Helper.get_pic_name_by_url(pic_url)
			hash = "#{pic_name}".crypt(site)
			unless db.has_key?(hash)
				#puts "wanna_save: #{pic_url}"
				open("#{pic_folder}/#{pic_name}#{File.extname(pic_url)}",'wb') do |picture|
					picture << open(pic_url).read
				end
			end 
		end
		db.close
	end

	def get_links(site)
		links = []
		db = Helper.get_db(site)
		pic_folder = get_pic_folder(site)
		db.keys.each do |key|
			block = db[key]
			pic_url = block[0]
			pic_name = Helper.get_pic_name_by_url(pic_url)
			links << "#{pic_folder}/#{pic_name}#{File.extname(pic_url)}"
		end
		db.close
		return links
	end

	def get_pic_folder(site)
		"./#{site}_pics"
	end
end
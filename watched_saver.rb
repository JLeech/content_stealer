require 'daybreak'
require_relative 'helper'

class WatchedSaver

	def save(data,site)
		#data= [[picture_url,news_description,views,news_link],...]
		db = Helper.get_db(site)
		data.each do |block|
			hash = "#{Helper.get_pic_name_by_url(block[0])}".reverse.crypt(site)
			db[hash] = block unless db.has_key?(hash)
		end
		db.flush
		db.close
	end

	def load(site)
		data = []
		db = Helper.get_db(site)
		db.keys.each do |key|
			data << db[key]
		end
		db.close
		return data
	end
end

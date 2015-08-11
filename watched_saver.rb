require 'daybreak'
require 'encryptor'
require_relative 'helper'


class WatchedSaver

	def save(data,site)
		#data= [[picture_url,news_description,views,news_link],...]
		db = Helper.get_db(site)
		iv = OpenSSL::Cipher::Cipher.new('aes-256-cbc').random_iv
		secret_key = site
		data.each do |block|
			hash = Encryptor.encrypt("#{Helper.get_pic_name_by_url(block[0])}",:key => secret_key, :iv => iv,:salt => "salt")
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

require_relative "siliconrus"
require_relative "ninegag"
require_relative "pikabu"
require_relative "mdk"
require_relative "tjournal"
require_relative "adme"
require_relative "lookatme"
require_relative "furfur"

puts "siliconrus started"
siliconrus_stealer = Siliconrus.new
siliconrus_stealer.refresh_news
siliconrus_stealer.generate_html
puts "siliconrus loaded"
puts "ninegag started"
ninegag_stealer = Ninegag.new
ninegag_stealer.refresh_news
ninegag_stealer.generate_html
puts "ninegag loaded"
puts "pikabu started"
pikabu_stealer = Pikabu.new
pikabu_stealer.refresh_news
pikabu_stealer.generate_html
puts "pikabu loaded"
puts "tjournal started"
tjournal_stealer = Tjournal.new
tjournal_stealer.refresh_news
tjournal_stealer.generate_html
puts "tjournal loaded"
puts "adme started"
adme_stealer = Adme.new
adme_stealer.refresh_news
adme_stealer.generate_html
puts "adme loaded"
puts "lookatme started"
lookatme_stealer = Lookatme.new
lookatme_stealer.refresh_news
lookatme_stealer.generate_html
puts "lookatme loaded"
puts "furfur started"
furfur_stealer = Furfur.new
furfur_stealer.refresh_news
furfur_stealer.generate_html
puts "furfur loaded"

#mdk_stealer = Mdk.new
#mdk_stealer.refresh_news()
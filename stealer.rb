require_relative "siliconrus"
require_relative "ninegag"
require_relative "pikabu"
require_relative "mdk"
require_relative "tjournal"

siliconrus_stealer = Siliconrus.new
siliconrus_stealer.refresh_news
siliconrus_stealer.generate_html#

ninegag_stealer = Ninegag.new
ninegag_stealer.refresh_news
ninegag_stealer.generate_html#

pikabu_stealer = Pikabu.new
pikabu_stealer.refresh_news
pikabu_stealer.generate_html

tjournal_stealer = Tjournal.new
tjournal_stealer.refresh_news
tjournal_stealer.generate_html

#mdk_stealer = Mdk.new
#mdk_stealer.refresh_news()
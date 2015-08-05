require_relative "siliconrus"
require_relative "ninegag"
require_relative "mdk"

siliconrus_stealer = Siliconrus.new
siliconrus_stealer.refresh_news
siliconrus_stealer.generate_html

ninegag_stealer = Ninegag.new
ninegag_stealer.refresh_news
ninegag_stealer.generate_html

#mdk_stealer = Mdk.new
#mdk_stealer.refresh_news()
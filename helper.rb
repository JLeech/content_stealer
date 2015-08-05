require 'erb'

class Helper
	
	include ERB::Util

	attr_accessor :news
	attr_accessor :site
	attr_accessor :pictures

	def self.get_pic_name_by_url(url)
		return File.basename(url,File.extname(url))
	end

	def self.get_db(site)
		Daybreak::DB.new(site)
	end

	def self.process_saving(news,name)
		format_name = name.to_s.downcase
		picture_saver = PictureSaver.new
		picture_saver.save(news,format_name)
		watch_saver = WatchedSaver.new
		watch_saver.save(news,format_name)
	end

	def get_template()
		%{
			<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01//EN\"
   			\"http://www.w3.org/TR/html4/strict.dtd\">
			<HTML>
			   <HEAD>
			      <TITLE><%= @site %></TITLE>
			   </HEAD>
			   <BODY>
			      <% @news.reverse.each_with_index do |block,index|%>
			      <ul style="list-style-type:circle">
					  <li>
					  	<a href=\" <%= block[3] %>\">
					  		<img src=\"<%= @links[@news.count - index -1] %>\"></img>
					  	</a>
					  </li>
					  <li> <%= block[1] %> </li>
					  <li> <%= block[2] %> </li>
				  </ul>
				 <%end%>
			   </BODY>
			</HTML>

		}
	end

	def render ()
		ERB.new(get_template).result(binding)
	end

	def render_to_html(site)
		name = site.to_s.downcase
		watch_saver = WatchedSaver.new
		@news = watch_saver.load(name)
		picture_saver = PictureSaver.new
		@links = picture_saver.get_links(name)
		@site = site
		File.open("./#{name}.html", "w") do |f|
			f.write(render)
		end
	end
end
require "#{File.dirname(__FILE__)}/lib/ncurses_gui/application"
require "#{File.dirname(__FILE__)}/lib/ncurses_gui/frame"

class MongoCurses < NCursesGui::Application
	def on_init
		@f = NCursesGui::Frame.new(parent: nil, title: 'MongoCurses')
		@f.show
	end

	def redraw
		@f.redraw
	end

end

app = MongoCurses.new

if $0 == __FILE__
	#puts 'MongoCurses is starting up ...'
	app.run!
end
require "#{File.dirname(__FILE__)}/common"

module NCursesGui
	class Window
		def show
			FFI::NCurses.wrefresh(@window)
		end
	end
end
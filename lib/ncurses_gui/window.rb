require "#{File.dirname(__FILE__)}/common"

module NCursesGui
	class Window
		def show
			FFI::NCurses.wrefresh(@window)
		end

		def get_dimensions(parent)
			height = FFI::NCurses.getmaxy(parent)
			width = FFI::NCurses.getmaxx(parent)
			return height, width
		end
	end
end
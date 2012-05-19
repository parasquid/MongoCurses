require "#{File.dirname(__FILE__)}/common"

module NCursesGui
	class Window
		def show
			FFI::NCurses.wrefresh(@window)
		end

		protected

		def get_dimensions(parent)
			height = FFI::NCurses.getmaxy(parent)
			width = FFI::NCurses.getmaxx(parent)
			return height, width
		end

		def get_height(parent)
			height = FFI::NCurses.getmaxy(parent)
		end

		def get_width(parent)
			width = FFI::NCurses.getmaxx(parent)
		end
	end
end
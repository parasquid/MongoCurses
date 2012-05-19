require "#{File.dirname(__FILE__)}/common"
require "#{File.dirname(__FILE__)}/window"

module NCursesGui
	class Frame < Window

		def initialize(options = {})
			@parent = options[:parent] || FFI::NCurses.stdscr
			@startx = options[:startx] || 0
			@starty = options[:starty] || 0
			@height = options[:height]
			@width = options[:width]
			@title = options[:title] || 'Frame'

			draw_frame

			@window
		end

		def redraw
			FFI::NCurses.endwin
			FFI::NCurses.refresh
			
			draw_frame

			FFI::NCurses.wrefresh(@window)

			@window
		end

		private

		def draw_frame
			draw_window
			draw_titlebar
		end

		def draw_window
			# TODO: what if width/height is larger than viewport?
			@height = get_height(@parent)
			@width = get_width(@parent)
			@window = FFI::NCurses.newwin(@height, @width, @startx, @starty)
			FFI::NCurses.wborder(@window, ACS_VLINE, ACS_VLINE, ACS_HLINE, ACS_HLINE, 0,0,0,0)
		end

		def draw_titlebar
			FFI::NCurses.mvwaddnstr(@window, @starty, midpoint(width: @width - @startx, length: @title.length), ' ' + @title + ' ', @width)
		end

	end
end
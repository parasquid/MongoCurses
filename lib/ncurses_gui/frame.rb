require "#{File.dirname(__FILE__)}/common"
require "#{File.dirname(__FILE__)}/window"

module NCursesGui
	class Frame < Window
		def initialize(options = {})
			@parent = options[:parent] || FFI::NCurses.stdscr
			(height, width) = get_dimensions(@parent)
			@startx = options[:startx] || 0
			@starty = options[:starty] || 0
			@window = FFI::NCurses.newwin(height, width, @startx, @starty)
			
			#int wborder(win, ls, rs, ts, bs, tl, tr, bl, br)
			FFI::NCurses.wborder(@window, ACS_VLINE, ACS_VLINE, ACS_HLINE, ACS_HLINE, 0,0,0,0)
			#box(window, startx, starty)  

			FFI::NCurses.start_color
			FFI::NCurses.init_pair(1, FFI::NCurses::COLOR_BLACK, FFI::NCurses::COLOR_RED)
			FFI::NCurses.attr_set FFI::NCurses::A_NORMAL, 1, nil

			@window
		end

		def redraw
			FFI::NCurses.endwin
			FFI::NCurses.refresh
			(height, width) = get_dimensions(@parent)
			#puts "#{height} #{width}"
			@window = FFI::NCurses.newwin(height, width, @startx, @starty)
			FFI::NCurses.wborder(@window, ACS_VLINE, ACS_VLINE, ACS_HLINE, ACS_HLINE, 0,0,0,0)

			FFI::NCurses.wrefresh(@window)

			@window
		end
	end
end
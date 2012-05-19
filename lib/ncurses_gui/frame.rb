require "#{File.dirname(__FILE__)}/common"
require "#{File.dirname(__FILE__)}/window"

module NCursesGui
	class Frame < Window
		def initialize(options = {})
			if options[:parent].nil?
				height = FFI::NCurses.getmaxy(FFI::NCurses.stdscr)
				width = FFI::NCurses.getmaxx(FFI::NCurses.stdscr)
				startx = 0
				starty = 0
			end
			@window = FFI::NCurses.newwin(height, width, startx, starty)
			
			#int wborder(win, ls, rs, ts, bs, tl, tr, bl, br)
			wborder(@window, ACS_VLINE, ACS_VLINE, ACS_HLINE, ACS_HLINE, 0,0,0,0)
			#box(window, startx, starty)  

			start_color
			init_pair(1, FFI::NCurses::COLOR_BLACK, FFI::NCurses::COLOR_RED)
			attr_set FFI::NCurses::A_NORMAL, 1, nil

			@window
		end

		def redraw
endwin
refresh
			height = FFI::NCurses.getmaxy(FFI::NCurses.stdscr)
			width = FFI::NCurses.getmaxx(FFI::NCurses.stdscr)
			startx = 0
			starty = 0
			#puts "#{height} #{width}"
			@window = FFI::NCurses.newwin(height, width, startx, starty)
			wborder(@window, ACS_VLINE, ACS_VLINE, ACS_HLINE, ACS_HLINE, 0,0,0,0)

			wrefresh(@window)

			@window
		end
	end
end
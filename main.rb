require 'ffi-ncurses'
include FFI::NCurses

def create_newwin(height, width, starty, startx)
	local_win = newwin(height, width, starty, startx)
	box(local_win, 0, 0)
	wrefresh(local_win)
	local_win
end

def destroy_win(local_win)
	wborder(local_win, 32, 32, 32, 32, 32, 32, 32, 32);
	wrefresh(local_win);
	delwin(local_win);
end

def lines
	FFI::NCurses.getmaxy(FFI::NCurses.stdscr)
end

def cols
	FFI::NCurses.getmaxx(FFI::NCurses.stdscr)
end

begin
  initscr
  cbreak

  keypad(stdscr, true)

  height = 3
  width = 10

  starty = (lines - height) / 2
  startx = (cols - width) / 2

  printw("Press F1 to exit")
  refresh

  my_win = create_newwin(height, width, starty, startx);

  while((ch = getch()) != KEY_F(1))
  	case ch
  		when KEY_LEFT
				destroy_win(my_win)
				startx = startx - 1
				my_win = create_newwin(height, width, starty, startx)
			when KEY_RIGHT
				destroy_win(my_win);
				startx = startx + 1
				my_win = create_newwin(height, width, starty, startx)
			when KEY_UP
				destroy_win(my_win);
				starty = starty - 1
				my_win = create_newwin(height, width, starty, startx)
			when KEY_DOWN
				destroy_win(my_win);
				starty = starty + 1
				my_win = create_newwin(height, width, starty, startx)
		end
  end
  
rescue => e
  FFI::NCurses.endwin
  raise
ensure
  FFI::NCurses.endwin
end

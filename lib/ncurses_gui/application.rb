require "#{File.dirname(__FILE__)}/common"
require "#{File.dirname(__FILE__)}/window"
require "#{File.dirname(__FILE__)}/frame"

module NCursesGui
  class Application
    def initialize(options = {})
      @application_name = options[:application_name]
    end

    def run!
      begin
        init_ncurses
        if respond_to? :on_init
          on_init
        end
        EM.run do
          Signal.trap('SIGWINCH') do
            redraw if respond_to? :redraw
          end
          #puts 'here'
        end
      rescue => e
        raise
      ensure
        FFI::NCurses.curs_set 1
	      FFI::NCurses.endwin
      end
    end

    private

    def init_ncurses
      FFI::NCurses.initscr
      FFI::NCurses.start_color
      FFI::NCurses.curs_set 0
      FFI::NCurses.raw
      FFI::NCurses.cbreak
      FFI::NCurses.noecho

      FFI::NCurses.start_color
      FFI::NCurses.init_pair(1, FFI::NCurses::COLOR_BLACK, FFI::NCurses::COLOR_RED)
      FFI::NCurses.attr_set FFI::NCurses::A_NORMAL, 1, nil

      #FFI::NCurses.keypad(FFI::NCurses.stdscr, true)

      refresh
    end

  end
end





class Test

  def timer
    Thread.new do
      loop do
        puts "[#{Time.now.strftime('%H:%M:%S')}]\n"
        sleep 1
      end
    end
  end

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

  def run

    begin
      initscr
      cbreak

      keypad(stdscr, true)
      mousemask(ALL_MOUSE_EVENTS | REPORT_MOUSE_POSITION, nil)
      mouse_event = FFI::NCurses::MEVENT.new

      height = 3
      width = 10

      starty = (lines - height) / 2
      startx = (cols - width) / 2

      printw("Press F1 to exit")
      refresh

      my_win = create_newwin(height, width, starty, startx);

      while((ch = getch()) != KEY_F(1))
        Signal.trap('SIGWINCH') do
          puts "window resized"
        end
        #puts ch
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

  end

end

require 'io/console'
require 'colorize'
require 'byebug'

class Display
  WASD_DIFFS = {
    'a' => [0, -1],
    's' => [1, 0],
    'd' => [0, 1],
    'w' => [-1, 0],
    "\r" => [0, 0]
  }

  attr_reader :board, :debug_mode, :game
  attr_accessor :cursor, :error_message

  def initialize(board, game)
    @board = board
    @game = game
    @cursor = [0,0]
    @selected = nil
    @debug_mode = false
    @error_message = nil
  end

  def select_square(num, current_player)
      move_cursor(current_player)
      @selected = (num == 1) ? cursor : nil;
      cursor
  end

  def render
    puts error_message if error_message
    chars_to_render = board.render
    chars_to_render.each_with_index do |row, row_index|
      row.each_with_index do |string, col_index|
        render_square(string, [row_index, col_index])
      end
      puts ""
    end
    debug_mode_print if debug_mode
  end

  def move_cursor(current_player)
    loop do
      system('clear')
      render
      puts "Turn: #{current_player.name}(#{current_player.color})"
      input = $stdin.getch
      raise Quit if input == 'q'
      next unless valid_input?(input)
      delta = WASD_DIFFS[input]
      break if delta == [0,0]
      new_pos = add_coordinates(cursor, delta)
      self.cursor = new_pos if self.board.in_bounds?(new_pos)
    end
  end

  def valid_input?(input)
    WASD_DIFFS.keys.include?(input)
  end

  def add_coordinates(x, y)
    [x.first + y.first, x.last + y.last]
  end

  def render_square(string, position)
    string = " #{string}  "
    if position == cursor
      string = string.colorize(:background => :yellow)
    elsif position == @selected
      string = string.colorize(:background => :yellow)
    elsif alternated_color?(position)
      string = string.colorize( :background => :light_blue)
    else
      string = string.colorize( :background => :magenta)
    end

    if debug_mode
      string = string.colorize(:background => :green) if board[cursor].possible_moves.include?(position)
    end
    print string
  end

  def alternated_color?(position)
    row, col = position
    alternate = false

    if row % 2 == 0
      alternate = true
    end

    if col % 2 == 0
      alternate = alternate ? false : true
    end
    alternate
  end

  def debug_mode_print
    puts "Cursor: #{cursor.inspect}"
    puts "Current Piece Possible Moves: #{board[cursor].possible_moves}"
    puts "Black in check?: #{board.in_check?(:black)}"
    puts "White in check?: #{board.in_check?(:white)}"
    puts "Checkmate black?: #{board.checkmate?(:black)}"
    puts "Checkmate white?: #{board.checkmate?(:black)}"
    puts "Object Class: #{board[cursor].class}"
    puts "Current Player: #{game.current_player.name}"
  end
end

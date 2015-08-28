require 'io/console'
require 'colorize'
require_relative 'board.rb'
require_relative 'empty_square.rb'
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
    @debug_mode = true
    @error_message = nil
    #debugger
  end

  def select_square
      move_cursor
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

  def move_cursor
    loop do
      system('clear')
      render
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
    elsif alternated_color?(position)
      string = string.colorize(:background => :red)
    else
      string = string.colorize(:background => :blue)
    end

    if debug_mode
      # piece = board.piece_at(position)
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
    # puts "Checkmate?: #{board.checkmate?(:white) || board.checkmate?(:black)}"
    puts "Object Class: #{board[cursor].class}"
    puts "Current Player: #{game.current_player.name}"
  end
end


if __FILE__ == $PROGRAM_NAME
  board = Board.new
  display = Display.new(board)
  display.get_move
end

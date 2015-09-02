require_relative '../board.rb'
require 'colorize'

class Piece
  HV_VECTORS = [[0, 1],
             [1, 0],
             [0, -1],
             [-1, 0]]
  DIAG_VECTORS = [[1, 1],
                 [-1, 1],
                 [1, -1],
                 [-1, -1]]

  attr_reader :color, :board, :symbol, :vectors, :value
  attr_accessor :captured, :moved, :position

  def initialize(position, color, board)
    @position = position
    @color = color
    @board = board
    @captured, @moved = false, false
  end

  def colored_symbol
    self.symbol.colorize(self.color)
  end

  def opponent_color
    (self.color == :white)? :black : :white
  end

  def self_blocking?(move)
    this_piece = board.piece_at(move)
    return false unless this_piece.piece?
    color == this_piece.color
  end

  def is_capture(position) #Used by pawn and by computer AI player
    self.board.in_bounds?(position) && self.board.color_at(position) == self.opponent_color
  end

  def to_s
    "Class: #{self.class}, Position: #{position}, Color: #{color}"
  end

  def empty?
    false
  end

  def piece?
    true
  end

  def dup(duped_board)
    self.class.new(position, color, duped_board)
  end

  def update_position(new_position)
    self.position = new_position
    self.moved = true
  end

  def possible_moves
    moves = moves_in_range.select do |move|
      board.in_bounds?(move) && !self_blocking?(move)
    end
  end

  def moves_in_range
    moves = []

    self.vectors.each do |vector|
      moves += moves_from_vector(vector)
    end
    moves
  end

  def step(vector)
    x, y = position
    dx, dy = vector
    [x + dx, y + dy]
  end

end

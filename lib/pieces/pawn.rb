class Pawn < Piece
  include Steppable
  attr_accessor :double_vector, :capture_vectors, :promotion_row

  def initialize(position, color, board)
    if (position[0] == 1)
      @vectors = [[1,0]]
      @double_vector = [2,0]
      @capture_vectors = [[1,-1], [1,1]]
      @promotion_row = 7
    else
      @vectors = [[-1,0]]
      @double_vector = [-2, 0]
      @capture_vectors = [[-1,-1], [-1,1]]
      @promotion_row = 0
    end
    super(position, color, board)
  end

  def is_promoted?
    self.position[0] == self.promotion_row
  end

  def is_capture(position)
    self.board.in_bounds?(position) && self.board.color_at(position) == self.opponent_color
  end

  #Returns vectors of currently allowed moves, taking into account if pawn has moved.
  def current_vectors
    self.moved ? self.vectors : self.vectors + [ self.double_vector ]
  end

  def moves_in_range
    moves = []
    current_vectors.each do |vector|
      pos = step(vector)
      moves << pos unless is_capture(pos)
    end
    moves += capture_moves
    moves
  end

  def capture_moves
    captures = []
    self.capture_vectors.each do |vector|
      pos = step(vector)
      captures << pos if is_capture(pos)
    end
    captures
  end

  def symbol
    color == :black ? "\u265F" : "\u2659"
  end

end

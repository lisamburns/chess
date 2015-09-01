class Pawn < SteppingPiece

  def initialize(position, color, board)
    @vectors = (color == :white) ? [[1,0]]: [[-1,0]]
    @capture_vectors = (color == :white) ? [[1,-1], [1,1]] : [[-1,-1], [-1,1]]
    @double_vector = (color == :white ) ? [2, 0] : [-2, 0]
    @promotion_row = (position[0] == 0) ? 7 : 0
    super(position, color, board)
  end

  def is_promoted?
    self.position[0] == self.promotion_row
  end

  def moves_in_range
    moves = []
    current_vectors = self.moved ? self.vectors : self.vectors + [self.double_vector]
    current_vectors.each do |vector|
      pos = move_from_vector(vector)
      moves << pos unless is_capture(pos)
    end
    moves += capture_moves
    moves
  end

  def move_from_vector(v)
    [v[0]+ self.position[0], v[1] + self.position[1]]
  end

  def capture_moves
    captures = []
    self.capture_vectors.each do |vector|
      pos = move_from_vector(vector)
      captures << pos if is_capture(pos)
    end
    captures
  end

  def is_capture(position)
    self.board.in_bounds?(position) && self.board.color_at(position) == self.opponent_color
  end

  def symbol
    color == :black ? "\u265F" : "\u2659"
  end

end

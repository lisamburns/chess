class Bishop < Piece
  include Slideable

  def initialize(position, color, board)
    @vectors = DIAG_VECTORS
    super(position, color, board)
  end
  def symbol
    color == :black ? "\u265D" : "\u2657"
  end

end

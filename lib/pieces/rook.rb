class Rook  < Piece
    include Slideable

  def initialize(position, color, board)
    @vectors = HV_VECTORS
    super(position, color, board)
  end

  def symbol
    color == :black ? "\u265C" : "\u2656"
  end

end

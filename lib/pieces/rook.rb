class Rook  < Piece
    include Slideable

  def initialize(position, color, board)
    @vectors = HV_VECTORS
    @symbol = "\u265C"
    super(position, color, board)
  end

end

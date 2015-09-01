class Bishop < Piece
  include Slideable

  def initialize(position, color, board)
    @vectors = DIAG_VECTORS
    @symbol = "\u265D"
    super(position, color, board)
  end

end

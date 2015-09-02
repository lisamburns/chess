class Bishop < Piece
  include Slideable

  def initialize(position, color, board)
    @vectors = DIAG_VECTORS
    @symbol = "\u265D"
    @value = 3
    super(position, color, board)
  end

end

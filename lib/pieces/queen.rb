class Queen < Piece
    include Slideable

  def initialize(position, color, board)
    @vectors = HV_VECTORS + DIAG_VECTORS
    super(position, color, board)
  end

  def symbol
    color == :black ? "\u265A" : "\u2654"
  end

end

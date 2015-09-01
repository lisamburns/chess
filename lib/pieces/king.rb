class King < Piece
  include Steppable

  def initialize(position, color, board)
    @vectors = HV_VECTORS + DIAG_VECTORS
    @symbol = "\u265A"
    super(position, color, board)
  end

end

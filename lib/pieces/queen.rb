class Queen < Piece
    include Slideable

  def initialize(position, color, board)
    @vectors = HV_VECTORS + DIAG_VECTORS
    @symbol =     "\u265B"
    @value = 9
    super(position, color, board)
  end

end

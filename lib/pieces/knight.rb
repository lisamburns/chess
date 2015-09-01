class Knight < Piece
  include Steppable
  L_VECTORS = [[2,1],
               [-2,1],
               [2,-1],
               [-2,-1],
               [1,2],
               [1,-2],
               [-1,2],
               [-1,-2]]

   def initialize(position, color, board)
     @vectors = L_VECTORS
     super(position, color, board)
   end

   def symbol
    color == :black ? "\u265E" : "\u2658"
  end

end

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
     @symbol = "\u265E"
     @value = 3
     super(position, color, board)
   end

end

class Player

  attr_accessor :display, :e
  attr_reader :board, :color, :name

  def initialize(name, color, display, board)
    @name = name
    @color = color
    @display = display
    @board = board
  end

  def ==(other_player)
    self.name == other_player.name
  end

  def take_turn
    position = display.select_square(1, self)
    destination = display.select_square(2, self)

    piece = board.piece_at(position)
    board.move(position, destination, color)
  end
end

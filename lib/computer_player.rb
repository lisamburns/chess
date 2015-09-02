class ComputerPlayer

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
    system('clear')
    self.display.render
    sleep(1) # Pause so human player can see the result of their move first.
    position, destination = choose_move

    piece = board.piece_at(position)
    board.move(position, destination, color)
  end

  def choose_move
    best_move_score = -500
    best_move = []
    self.board.all_moves(self.color).each do |move|
      if move_score(move) > best_move_score
        best_move = move
        best_move_score = move_score(move)
      end
    end
    best_move
  end

  def move_score(move)
    position, new_position = move
    other_player = (self.color == :black) ? :white : :black
    dup = self.board.duped_board
    dup.move_piece!(position, new_position)
    return 1000 if dup.checkmate?(other_player)
    return dup.scores[self.color] - dup.scores[other_player] - dup.max_capture_value(other_player)
  end


end

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
    position, destination = choose_move

    piece = board.piece_at(position)
    board.move(position, destination, color)
  end

  def choose_move
    best_move_score = 0
    best_move = []
    all_moves.each do |move|
      if move_score(move) > best_move_score
        best_move = move
        best_move_score = move_score(move)
      end
    end
    puts best_move_score
    p best_move
    best_move
  end

  def move_score(move)
    position, new_position = move
    other_player = (self.color == :black) ? :white : :black
    dup = self.board.duped_board
    dup.move_piece!(position, new_position)
    return 1000 if dup.checkmate?(other_player)
    return 500 if dup.in_check?(other_player)
    return 100 if self.board.piece_at(position).is_capture(new_position)
    return 50
  end

  def all_moves
    moves = []

    self.board.find_pieces(self.color).each do |piece|
      piece.possible_moves.each do |move|
        moves << [ piece.position, move ] if self.board.valid_move?(piece.position, move, self.color)# Later exclude moving into check!
      end
    end
    moves.shuffle
  end

end

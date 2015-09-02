require_relative 'lib/board'
require_relative 'lib/display'
require_relative 'lib/player'
require_relative 'lib/computer_player'

class Game
  attr_accessor :current_player
  attr_reader :player1, :player2, :board, :display

  def initialize
    @board = Board.new
    @display = Display.new(board, self)
    @player1 = ComputerPlayer.new("ChessMachine2000", :black, display, board)
    @player2 = Player.new("Player 1", :white, display, board)
    @current_player = player2
  end

  def play
    display.render
    until board.checkmate?(current_player.color)
      begin
        current_player.take_turn
      rescue InvalidMove => e
        display.error_message = e.message
        retry
      rescue NotYourPiece => e
        display.error_message = e.message
        retry
      rescue Quit => e
        puts "You have quit"
        break
      end
      display.error_message = nil
      switch_players
    end
    display.render
    puts "#{current_player.name} loses"
  end

  def switch_players
    self.current_player = (current_player == player1) ? player2 : player1
  end

end

if __FILE__ == $PROGRAM_NAME
  game = Game.new
  game.play
end

# Chess
The classic strategy game that you can play in the terminal, implemented in Ruby.
* Only legal moves are allowed.
* You can not move into check.

##To Play
Open a terminal, clone the repository and change into the chess directory.
Run 'ruby game.rb' from the terminal. Press q at any time to quit.
Use the keys "wasd" to navigate up/left/down/right on the display.
Hit enter to select a piece, use 'wasd' to select the square to move the piece to, then hit enter.

## Implementation
Chess was implemented with an object-oriented approach in Ruby. There are separate classes for the Display, Board, Game, Pieces, and
subclasses for types of pieces, including a subclass for empty squares. There are modules for stepping and sliding pieces. Preventing players from moving into check is done by creating a deep duplicate of the board, then checking if the duplicated board is in check.

##Future improvements
* Implement castling

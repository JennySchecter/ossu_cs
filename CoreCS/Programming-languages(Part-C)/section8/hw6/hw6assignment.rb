# University of Washington, Programming Languages, Homework 6, hw6runner.rb

# This is the only file you turn in, so do not modify the other files as
# part of your solution.
#require_relative "./hw6provided.rb";

class MyPiece < Piece
    
  # The constant All_My_Pieces should be declared here
  All_My_Pieces = Piece::All_Pieces.concat([rotations([[0, 0], [1, 0], [0, 1], [1, 1],[2,1]]),
                                           [[[-2,0],[-1,0],[0,0],[1,0],[2,0]], # five long (only needs two)
                                           [[0,-2],[0,-1],[0,0],[0,1],[0,2]]],
                                           rotations([[0,0],[0,1],[1,1]])
                                           ])

  Cheat_Piece = [[[0,0]]]
  # your enhancements here

  def self.next_piece (board)
    if board.is_cheat
    then
      MyPiece.new(Cheat_Piece,board)
    else
      MyPiece.new(All_My_Pieces.sample,board)
    end
  end

end

class MyBoard < Board
  # your enhancements here
  def initialize (game)
    super(game)
    @current_block = MyPiece.next_piece(self)
    @is_cheat = false
  end

  # rotates the current piece 180 degrees
  def rotate_180
    if !game_over? and @game.is_running?
      @current_block.move(0,0,2)
    end
    draw
  end

  # gets the next piece
  def next_piece
    @current_block = MyPiece.next_piece(self)
    @current_pos = nil
    @is_cheat=false
  end

  # should override this method,cus the pieces not always 4 point
  def store_current
    locations = @current_block.current_rotation
    displacement = @current_block.position
    (0..(locations.size-1)).each{|index| 
      current = locations[index];
      @grid[current[1]+displacement[1]][current[0]+displacement[0]] = 
      @current_pos[index]
    }
    remove_filled
    @delay = [@delay - 2, 80].max
  end

  # cheat piece
  def cheat
    if !@is_cheat and @score >= 100
      @is_cheat = true
      @score -= 100
    end
  end

  def is_cheat
    @is_cheat
  end
  
end

class MyTetris < Tetris
  # your enhancements here

  def set_board
    @canvas = TetrisCanvas.new
    @board = MyBoard.new(self)
    @canvas.place(@board.block_size * @board.num_rows + 3,
                  @board.block_size * @board.num_columns + 6, 24, 80)
    @board.draw
  end

  # add press 'u' make piece rotate 180 degrees
  def key_bindings
    super
    @root.bind('u',proc {@board.rotate_180})
    @root.bind('c',proc {@board.cheat})
  end
  
end


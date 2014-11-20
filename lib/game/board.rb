require 'game'

module Game
  # The Board holds all the X and O. It only knows whether it is valid or not.
  class Board
    EMPTY_BOARD = EMPTY*9

    def initialize(board = EMPTY_BOARD)
      @board = board
    end

    def empty?
      @board == EMPTY_BOARD
    end

    def valid?
      chars = @board.chars
      x_plays = chars.select{|c| c == X}.length
      o_plays = chars.select{|c| c == O}.length

      x_plays == o_plays || x_plays == o_plays + 1
    end
  end
end

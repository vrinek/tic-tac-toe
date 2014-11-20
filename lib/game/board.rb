require 'game'

module Game
  # The Board holds all the X and O. It only knows whether it is valid or not.
  class Board
    EMPTY_BOARD_STR = EMPTY*9

    class InvalidMove < StandardError; end

    def initialize(board_str = EMPTY_BOARD_STR)
      @board_str = board_str
    end

    def empty?
      @board_str == EMPTY_BOARD_STR
    end

    def play(what, where)
      unless @board_str[where] == EMPTY
        raise InvalidMove.new("There is already a mark in space #{where}.")
      end

      new_board_str = @board_str.dup
      new_board_str[where] = what

      Board.new(new_board_str)
    end

    def valid?
      chars = @board_str.chars
      x_plays = chars.select{|c| c == X}.length
      o_plays = chars.select{|c| c == O}.length

      x_plays == o_plays || x_plays == o_plays + 1
    end
  end
end

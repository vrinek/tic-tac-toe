require 'game'
require 'game/move'
require 'game/board_progression'
require 'game/board_endgame'

module Game
  # The Board is the state.
  # It holds all the X and O.
  # It knows whether it is valid or not.
  # It knows how to transition to a new board.
  class Board
    include BoardProgression
    include BoardEndgame

    EMPTY_BOARD_STR = EMPTY * 9

    def initialize(board_str = EMPTY_BOARD_STR)
      @board_str = board_str
    end

    def spaces
      @board_str.chars
    end

    def id
      @board_str.to_i(3)
    end

    def ==(other)
      other.is_a?(self.class) && id == other.id
    end

    def values_at(*args)
      spaces.values_at(*args)
    end

    def empty?
      @board_str == EMPTY_BOARD_STR
    end

    def full?
      !spaces.find{|c| c == EMPTY}
    end

    def valid?
      valid_str?(@board_str)
    end

    def [](index)
      @board_str[index]
    end

    private

    def valid_str?(string)
      chars = string.chars
      x_plays = chars.select{|c| c == X}.length
      o_plays = chars.select{|c| c == O}.length

      x_plays == o_plays || x_plays == o_plays + 1
    end
  end
end

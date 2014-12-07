require 'game'
require 'game/move'

module Game
  # The Board is the state.
  # It holds all the X and O.
  # It knows whether it is valid or not.
  # It knows how to transition to a new board.
  class Board
    EMPTY_BOARD_STR = EMPTY * 9

    class InvalidMove < StandardError; end

    def initialize(board_str = EMPTY_BOARD_STR)
      @board_str = board_str
    end

    def to_a
      @board_str.chars
    end

    def to_s
      @board_str
    end

    def pretty_print
      markings = {
        Game::EMPTY => " ",
        Game::X     => "x",
        Game::O     => "o",
      }
      pretty_board = to_a.map { |m| markings[m] }

      print " " + pretty_board[0, 3].join(" | ") + " \n" +
            "-" * 11 + "\n" +
            " " + pretty_board[3, 3].join(" | ") + " \n" +
            "-" * 11 + "\n" +
            " " + pretty_board[6, 3].join(" | ") + " \n"
    end

    def ==(other)
      other.is_a?(self.class) && to_s == other.to_s
    end

    def values_at(*args)
      to_a.values_at(*args)
    end

    def empty?
      @board_str == EMPTY_BOARD_STR
    end

    def full?
      !to_a.find{|c| c == EMPTY}
    end

    def play(what, where)
      unless @board_str[where] == EMPTY
        raise InvalidMove.new("There is already a mark in space #{where}.")
      end

      new_board_str = @board_str.dup
      new_board_str[where] = what

      unless valid_str?(new_board_str)
        raise InvalidMove.new("The other player should be playing.")
      end

      Board.new(new_board_str)
    end

    def valid?
      valid_str?(@board_str)
    end

    def [](index)
      @board_str[index]
    end

    def next_moves
      moves = []
      to_a.each_with_index do |mark, index|
        if mark == EMPTY
          moves << Move.new(current_player, index)
        end
      end
      moves
    end

    def current_player
      x_plays = to_a.select{|s| s == X}.length
      o_plays = to_a.select{|s| s == O}.length

      x_plays <= o_plays ? X : O
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

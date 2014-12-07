require 'game'

module Game
  # The Progression holds the connections between states.
  # It knows which moves are available at each possible state.
  # It knows whose player's turn it is to play.
  module BoardProgression
    class OccupiedSpace < StandardError; end
    class WrongPlayer < StandardError; end

    def next_moves
      moves = []
      spaces.each_with_index do |mark, index|
        if mark == EMPTY
          moves << Move.new(current_player, index)
        end
      end
      moves
    end

    def current_player
      x_plays = spaces.select{|s| s == X}.length
      o_plays = spaces.select{|s| s == O}.length

      x_plays <= o_plays ? X : O
    end

    def play(what, where)
      unless @board_str[where] == EMPTY
        raise OccupiedSpace.new
      end

      new_board_str = @board_str.dup
      new_board_str[where] = what

      unless valid_str?(new_board_str)
        raise WrongPlayer.new
      end

      Board.new(new_board_str)
    end
  end
end

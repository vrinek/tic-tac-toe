require 'game'
require 'game/move'

module Game
  class Progression
    def initialize(board)
      @board = board
    end

    def next_moves
      moves = []
      @board.to_a.each_with_index do |mark, index|
        if mark == EMPTY
          moves << Move.new(current_player, index)
        end
      end
      moves
    end

    def current_player
      spaces = @board.to_a

      x_plays = spaces.select{|s| s == X}.length
      o_plays = spaces.select{|s| s == O}.length

      x_plays <= o_plays ? X : O
    end
  end
end

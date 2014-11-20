require 'game'
require 'game/board'

module Game
  class EndCondition
    WIN_INDEX_TRIPLETS = [
      # horizontal
      [0, 1, 2], [3, 4, 5], [6, 7, 8],
      # vertical
      [0, 3, 6], [1, 4, 7], [2, 5, 8],
      # diagonal
      [0, 4, 8], [2, 4, 6],
    ]

    def initialize(board)
      @board = board
    end

    def x_won?
      WIN_INDEX_TRIPLETS.any? do |triplet|
        @board.values_at(*triplet) == [X, X, X]
      end
    end

    def o_won?
      WIN_INDEX_TRIPLETS.any? do |triplet|
        @board.values_at(*triplet) == [O, O, O]
      end
    end

    def draw?
      @board.full? && !o_won? && !x_won?
    end
  end
end

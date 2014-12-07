require 'game'
require 'game/board'

module Game
  # The Endgame holds the logic for the end of the game.
  # It knows if the game has ended.
  # It knows who won the game or if it ended into a draw.
  module BoardEndgame
    WIN_INDEX_TRIPLETS = [
      # horizontal
      [0, 1, 2], [3, 4, 5], [6, 7, 8],
      # vertical
      [0, 3, 6], [1, 4, 7], [2, 5, 8],
      # diagonal
      [0, 4, 8], [2, 4, 6],
    ]

    def ended?
      x_won? || o_won? || draw?
    end

    def state
      case
      when x_won? then "X won"
      when o_won? then "O won"
      when draw? then "Draw"
      else "In progress"
      end
    end

    def x_won?
      WIN_INDEX_TRIPLETS.any? do |triplet|
        values_at(*triplet) == [X, X, X]
      end
    end

    def o_won?
      WIN_INDEX_TRIPLETS.any? do |triplet|
        values_at(*triplet) == [O, O, O]
      end
    end

    def draw?
      full? && !o_won? && !x_won?
    end
  end
end

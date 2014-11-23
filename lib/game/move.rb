require 'game'

module Game
  # The Move is the action.
  # This is what a player does in order to advance the game to a new state.
  class Move < Struct.new(:what, :where)
    def apply_to(board)
      board.play(what, where)
    end
  end
end

require 'game'

module Game
  class Move < Struct.new(:what, :where)
    def apply_to(board)
      board.play(what, where)
    end
  end
end

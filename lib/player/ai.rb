require 'player/base'
require 'game/playbook'

module Player
  class AI < Base
    def initialize(mark)
      @mark = mark
      @playbook = Game::Playbook.new
    end

    def show_state(board)
      @playbook.precompile! unless @playbook.precompiled?
      @board = board
    end

    def ask_for_input
      @playbook.best_moves(@board).sample.where
    end
  end
end

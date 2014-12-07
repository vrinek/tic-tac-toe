require 'player/base'
require 'game/precompiled_playbook'

module Player
  class Computer < Base
    def initialize(mark)
      @mark = mark
      @playbook = Game::PrecompiledPlaybook.new
    end

    def show_state(board)
      @board = board
    end

    def ask_for_input
      @playbook.best_moves(@board).sample.where
    end
  end
end

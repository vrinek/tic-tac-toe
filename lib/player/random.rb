require 'player/base'

module Player
  class Random < Base
    def ask_for_input
      (0..8).to_a.sample
    end
  end
end

require 'player'

module Player
  class Base
    def initialize(mark); end
    def ask_for_input; end
    def show_state(board); end
    def show_exception(exception); end
    def show_intro; end
    def show_end_message(end_condition); end
  end
end

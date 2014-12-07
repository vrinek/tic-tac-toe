require 'game'
require 'game/board'
require 'game/end_condition'

module Game
  class Interface
    class InvalidInputNumber < StandardError; end
    class OccupiedSpace < StandardError; end

    def initialize(starting_board = Board.new)
      @board = starting_board
    end

    def start(x_player_class, o_player_class, announce_result: false)
      players = [x_player_class.new("X"), o_player_class.new("O")]

      players.each(&:show_intro)
      players.cycle do |player|
        player.show_state(@board)

        begin
          process_input(player.ask_for_input)
        rescue OccupiedSpace, InvalidInputNumber => exc
          player.show_exception(exc)
          retry
        end

        break if end_condition.ended?
      end

      players.each do |player|
        player.show_state(@board)
        player.show_end_message(end_condition)
      end

      puts end_condition if announce_result
    end

    private

    def end_condition
      EndCondition.new(@board)
    end

    def process_input(input)
      input = input.to_s.strip
      raise InvalidInputNumber.new unless input =~ /^\d$/

      input = input.to_i
      begin
        @board = @board.play(@board.current_player, input)
      rescue Board::OccupiedSpace
        raise OccupiedSpace.new
      end
    end
  end
end

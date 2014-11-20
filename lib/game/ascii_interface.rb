require 'game'
require 'game/board'
require 'game/progression'
require 'game/end_condition'

module Game
  class AsciiInterface
    MARKS = " XO"

    def initialize
      @board = Board.new
    end

    def start
      print_intro

      loop do
        print_state
        print_prompt
        process_input(STDIN.gets)
        break if game_ended?
      end

      print_state
      print_end_message
    end

    private

    def game_ended?
      end_condition.x_won? ||
      end_condition.o_won? ||
      end_condition.draw?
    end

    def print_end_message
      if end_condition.x_won?
        puts "X won!"
      elsif end_condition.o_won?
        puts "O won!"
      elsif end_condition.draw?
        puts "It's a draw."
      end
    end

    def print_intro
      puts "Welcome to a game of Tic-Tac-Toe!"
      puts "The board positions can be selected by the Numpad."
    end

    def progression
      Progression.new(@board)
    end

    def end_condition
      EndCondition.new(@board)
    end

    def print_state
      marks = @board.to_a.map { |m| MARKS[m.to_i] }

      print " " + marks[0, 3].join(" | ") + " \n" +
            "-" * 11 + "\n" +
            " " + marks[3, 3].join(" | ") + " \n" +
            "-" * 11 + "\n" +
            " " + marks[6, 3].join(" | ") + " \n"
    end

    def print_prompt
      current_mark = progression.current_player == X ? "X" : "O"
      print  "Please enter move for player #{current_mark}: "
    end

    def process_input(input)
      input = input.strip
      raise InvalidInput.new("Please enter a number from 1 to 9.") unless input =~ /^\d$/

      input = input.to_i
      begin
        @board = @board.play(progression.current_player, input)
      rescue InvalidMove => exc
        raise InvalidInput.new("This space is already occupied, please select a different one.")
      end
    end
  end
end

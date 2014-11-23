require 'player/base'

module Player
  class Human < Base
    MARKS = {
      Game::EMPTY => " ",
      Game::X     => "X",
      Game::O     => "O",
    }

    BOARD_TO_NUMPAD = [
      7, 8, 9,
      4, 5, 6,
      1, 2, 3,
    ]

    def initialize(mark)
      @mark = MARKS[mark]
    end

    def ask_for_input
      print "Please enter move for player #{@mark}: "

      numpad_to_board(STDIN.gets)
    end

    def show_state(board)
      marks = board.to_a.map { |m| MARKS[m] }

      print " " + marks[0, 3].join(" | ") + " \n" +
            "-" * 11 + "\n" +
            " " + marks[3, 3].join(" | ") + " \n" +
            "-" * 11 + "\n" +
            " " + marks[6, 3].join(" | ") + " \n"
    end

    def show_exception(exception)
      puts exception
    end

    def show_intro
      puts "Welcome to a game of Tic-Tac-Toe!"
      puts "The board positions can be selected by using the Numpad."
    end

    def show_end_message(end_condition)
      if end_condition.x_won?
        puts "X won!"
      elsif end_condition.o_won?
        puts "O won!"
      elsif end_condition.draw?
        puts "It's a draw."
      end
    end

    private

    def numpad_to_board(numpad_key)
      BOARD_TO_NUMPAD.index(numpad_key.to_i)
    end
  end
end
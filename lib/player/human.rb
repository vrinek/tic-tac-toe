require 'player/base'
require 'game/interface'
require 'ansi'

module Player
  class Human < Base
    BOARD_TO_NUMPAD = [
      7, 8, 9,
      4, 5, 6,
      1, 2, 3,
    ]

    MARKINGS = {
      Game::X => ANSI.red  + "x" + ANSI.clear,
      Game::O => ANSI.blue + "o" + ANSI.clear,
    }

    def initialize(mark)
      @mark = mark
    end

    def ask_for_input
      print "Please enter move for player #{@mark}: "

      numpad_to_board(STDIN.gets)
    end

    def show_state(board)
      pretty_board = board.to_a.map { |m| MARKINGS[m] }
      # add hints to empty spaces
      pretty_board.each_index do |i|
        pretty_board[i] ||= ANSI.black + BOARD_TO_NUMPAD[i].to_s + ANSI.clear
      end

      print " " + pretty_board[0, 3].join(" | ") + " \n" +
            "-" * 11 + "\n" +
            " " + pretty_board[3, 3].join(" | ") + " \n" +
            "-" * 11 + "\n" +
            " " + pretty_board[6, 3].join(" | ") + " \n"
    end

    def show_exception(exception)
      msg = case
      when exception.kind_of?(Game::Interface::OccupiedSpace)
        "This space is already occupied, please select a different one."
      when exception.kind_of?(Game::Interface::InvalidInputNumber)
        "Please enter a number from 1 to 9."
      else
        "Unknown error! - #{exception}"
      end

      puts ANSI.red + msg + ANSI.clear
    end

    def show_intro
      puts "Welcome to a game of Tic-Tac-Toe!"
      puts "The board positions can be selected by using the Numpad."
    end

    def show_end_message(end_condition)
      if end_condition.x_won? && @mark == "X" || end_condition.o_won? && @mark == "O"
        puts "You won!"
      elsif end_condition.o_won? && @mark == "X" || end_condition.x_won? && @mark == "O"
        puts "You lost..."
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

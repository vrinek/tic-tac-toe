require 'player/base'

module Player
  class Human < Base
    BOARD_TO_NUMPAD = [
      7, 8, 9,
      4, 5, 6,
      1, 2, 3,
    ]

    def initialize(mark)
      @mark = mark
    end

    def ask_for_input
      print "Please enter move for player #{@mark}: "

      numpad_to_board(STDIN.gets)
    end

    def show_state(board)
      board.pretty_print
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

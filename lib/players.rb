require 'game'

class Player
  def initialize(mark); end
  def ask_for_input; end
  def show_state(board); end
  def show_exception(exception); end
  def show_intro; end
  def show_end_message(end_condition); end
end

class RandomPlayer < Player
  def ask_for_input
    (0..8).to_a.sample
  end
end

class HumanPlayer < Player
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

class AIPlayer < Player
  MAX_DISTANCE = 10

  def initialize(mark)
    @mark = mark
    @playbook = {
      # board_str => [D, X, O],
      "000000000" => [9, 3, 3],
      "110200000" => [6, 1, 2],
      "100200000" => [7, 2, 2],
      "100200100" => [6, 2, 2],
    }
  end

  def ask_for_input
    best_move.to_a.each_with_index do |tile, index|
      return index if tile != @board.to_a[index]
    end
  end

  def show_state(board)
    @board = board
  end

  def show_exception(exception)
    # This should never happen, the AI should only consider valid moves.
    raise exception
  end

  private

  def possible_moves
    Game::Progression.new(@board).next_moves
  end

  def best_move
    favorable_moves = possible_moves.reject do |move|
      distance_to_lose(move) == 1 # would be like throwing the game
    end

    best_winning_move = favorable_moves.sort_by{|m| distance_to_win(m)}.first

    if distance_to_win(best_winning_move) == MAX_DISTANCE # not possible to win
      best_draw_move = possible_moves.sort_by{|m| distance_to_draw(m)}.first
      if distance_to_draw(best_draw_move) == MAX_DISTANCE
        favorable_moves.sample
      end
    else
      best_winning_move
    end
  end

  def distance_to_win(board)
    distances = @playbook[board.to_s]
    distances ? distances[@mark == Game::X ? 1 : 2] : MAX_DISTANCE
  end

  def distance_to_draw(board)
    distances = @playbook[board.to_s]
    distances ? distances[0] : MAX_DISTANCE
  end

  def distance_to_lose(board)
    distances = @playbook[board.to_s]
    distances ? distances[@mark == Game::X ? 2 : 1] : MAX_DISTANCE
  end
end

require 'game'
require 'game/board'
require 'game/end_condition'
require 'json'

module Game
  class Playbook
    MAX = +1 # X wins
    MIN = -1 # O wins
    DRAW = 0

    PLAYBOOK_FILENAME = "tmp/playbook.json"

    def precompile!
      filename = PLAYBOOK_FILENAME

      if File.exists?(filename)
        File.open(filename) do |file|
          @precompiled_values = JSON.parse(file.read)
        end
      else
        @precompiled_values = {}
        value(Game::Board.new) # traverses all states and saves the values

        File.open(filename, 'w') do |file|
          file.puts(@precompiled_values.to_json)
        end
      end

      @precompiled = true
    end

    def precompiled?
      !!@precompiled
    end

    def best_moves(board)
      moves_map = board.next_moves.each_with_object({}) do |move, map|
        next_board = move.apply_to(board)
        v = value(next_board)
        map[v] ||= []
        map[v] << move
      end

      if board.current_player == X
        moves_map[MAX] || moves_map[DRAW] || moves_map[MIN]
      else
        moves_map[MIN] || moves_map[DRAW] || moves_map[MAX]
      end
    end

    def value(board)
      if @precompiled_values && @precompiled_values[board.to_s]
        return @precompiled_values[board.to_s]
      end

      end_condition = EndCondition.new(board)

      value = case
      # either the game has ended
      when end_condition.x_won?      then MAX
      when end_condition.o_won?      then MIN
      when end_condition.draw?       then DRAW
      # or it is still in progress
      when board.current_player == X then next_values(board).max
      when board.current_player == O then next_values(board).min
      end

      if @precompiled_values
        @precompiled_values[board.to_s] = value
      end

      value
    end

    private

    def next_values(board)
      board.next_moves.map do |move|
        next_board = move.apply_to(board)
        value(next_board)
      end
    end
  end
end

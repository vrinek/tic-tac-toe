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

      value = if end_condition.ended?
        final_value(end_condition)
      elsif board.current_player == X
        max_value(board)
      else
        min_value(board)
      end

      if @precompiled_values
        @precompiled_values[board.to_s] = value
      end

      value
    end

    private

    def final_value(end_condition)
      return MAX  if end_condition.x_won?
      return MIN  if end_condition.o_won?
      return DRAW if end_condition.draw?
    end

    def max_value(board)
      next_values(board).max
    end

    def min_value(board)
      next_values(board).min
    end

    def next_values(board)
      board.next_moves.map do |move|
        next_board = move.apply_to(board)
        value(next_board)
      end
    end
  end
end

require 'game'
require 'game/board'
require 'game/progression'
require 'game/end_condition'

module Game
  class Playbook
    MAX = +1 # X wins
    MIN = -1 # O wins
    DRAW = 0

    def best_moves(board)
      progression = Progression.new(board)
      moves_map = {MIN => [], DRAW => [], MAX => []}
      progression.next_moves.each do |move|
        next_board = move.apply_to(board)
        moves_map[value(next_board)] << move
      end

      if progression.current_player == X
        moves_map[MAX].any? ? moves_map[MAX] : moves_map[DRAW]
      else
        moves_map[MIN].any? ? moves_map[MIN] : moves_map[DRAW]
      end
    end

    def value(board)
      end_condition = EndCondition.new(board)

      if end_condition.ended?
        final_value(end_condition)
      elsif Progression.new(board).current_player == X
        max_value(board)
      else
        min_value(board)
      end
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
      Progression.new(board).next_moves.map do |move|
        next_board = move.apply_to(board)
        value(next_board)
      end
    end
  end
end

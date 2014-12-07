require 'game'
require 'game/playbook'
require 'json'

module Game
  class PrecompiledPlaybook < Playbook
    PLAYBOOK_FILENAME = "tmp/playbook.json"

    def initialize
      super

      filename = PLAYBOOK_FILENAME

      if File.exists?(filename)
        File.open(filename) do |file|
          @values = JSON.parse(file.read)
        end
      else
        @values = []
        value(Game::Board.new) # traverses all states and saves the values

        File.open(filename, 'w') do |file|
          file.puts(@values.to_json)
        end
      end
    end

    def value(board)
      if @values[board.id]
        @values[board.id]
      else
        @values[board.id] = super
      end
    end
  end
end

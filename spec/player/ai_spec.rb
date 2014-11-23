require 'player/ai'
require 'game/board'

describe Player::AI do
  context "on a board where the opponent is about to win" do
    let(:board) { Game::Board.new("100220001") }
    subject { Player::AI.new("X") }

    before { subject.show_state(board) }

    it "blocks" do
      expect(subject.ask_for_input).to eql(5)
    end
  end

  context "on a board where the player is about to win" do
    let(:board) { Game::Board.new("002110002") }
    subject { Player::AI.new("X") }

    before { subject.show_state(board) }

    it "wins the game" do
      expect(subject.ask_for_input).to eql(5)
    end
  end
end

require 'game/playbook'
require 'game/board'

describe Game::Playbook do
  subject { Game::Playbook.new }

  context "on a board where the opponent is about to win" do
    let(:board) { Game::Board.new("100220001") }

    it "advices on blocking" do
      expect(subject.best_moves(board)).to eql([Game::Move.new(Game::X, 5)])
    end
  end

  context "on a board that has been won by O" do
    let(:board) { Game::Board.new("101222001") }

    it "calculates the value as MIN" do
      expect(subject.value(board)).to eql(Game::Playbook::MIN)
    end
  end

  context "on a board that is about to be won by O" do
    let(:board) { Game::Board.new("101202001") }

    it "calculates the value as MIN" do
      expect(subject.value(board)).to eql(Game::Playbook::MIN)
    end

    it "advices O to win the board" do
      expect(subject.best_moves(board)).to eql([Game::Move.new(Game::O, 4)])
    end
  end

  context "on a board that is about to be won by X" do
    let(:board) { Game::Board.new("022110000") }

    it "calculates the value as MAX" do
      expect(subject.value(board)).to eql(Game::Playbook::MAX)
    end

    it "advices X to win it or fork it" do
      expect(subject.best_moves(board)).to contain_exactly(
        Game::Move.new(Game::X, 5),
        Game::Move.new(Game::X, 0),
      )
    end
  end
end

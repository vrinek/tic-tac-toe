require 'game/board'

describe Game::Board do
  context "a newly created board" do
    subject { Game::Board.new }

    it { is_expected.to be_empty }
    it { is_expected.to be_valid }
  end

  context "a board with a few of moves" do
    subject { Game::Board.new.play(Game::X, 3).play(Game::O, 4).play(Game::X, 7) }

    it { is_expected.to_not be_empty }
    it { is_expected.to be_valid }
  end

  context "a board with invalid moves" do
    subject { Game::Board.new.play(Game::X, 3).play(Game::X, 7) }

    it { is_expected.to_not be_valid }
  end
end

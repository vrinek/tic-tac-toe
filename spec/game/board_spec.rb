require 'game/board'

describe Game::Board do
  context "a newly created board" do
    subject { Game::Board.new }

    it { is_expected.to be_empty }
    it { is_expected.to be_valid }
    it { is_expected.to_not be_full }

    it "is equal to another empty Game::Board" do
      expect(subject == Game::Board.new).to be_truthy
    end
  end

  context "a board with a few of moves" do
    subject do
      Game::Board.new.
        play(Game::X, 3).play(Game::O, 4).
        play(Game::X, 7)
    end

    it { is_expected.to_not be_empty }
    it { is_expected.to be_valid }
    it { is_expected.to_not be_full }

    it "is not equal to an empty Game::Board" do
      expect(subject == Game::Board.new).to be_falsey
    end
  end

  context "a board with invalid moves" do
    subject { Game::Board.new("001001000") }

    it { is_expected.to_not be_valid }
  end

  context "a filled up board" do
    subject do
      Game::Board.new.
        play(Game::X, 0).play(Game::O, 1).
        play(Game::X, 3).play(Game::O, 6).
        play(Game::X, 2).play(Game::O, 4).
        play(Game::X, 7).play(Game::O, 8).
        play(Game::X, 5)
    end

    it { is_expected.to be_full }
    it { is_expected.to_not be_empty }
  end
end

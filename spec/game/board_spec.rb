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

  describe "next moves" do
    subject { board.next_moves }

    context "on an empty board" do
      let(:board) { Game::Board.new }

      it { expect(subject.length).to eql(9) }

      it "returns one Game::Move for each space" do
        expected_moves = [
          Game::Move.new(Game::X, 0),
          Game::Move.new(Game::X, 1),
          Game::Move.new(Game::X, 2),
          Game::Move.new(Game::X, 3),
          Game::Move.new(Game::X, 4),
          Game::Move.new(Game::X, 5),
          Game::Move.new(Game::X, 6),
          Game::Move.new(Game::X, 7),
          Game::Move.new(Game::X, 8),
        ]

        is_expected.to contain_exactly(*expected_moves)
      end

      it "returns and Array of Game::Move instances" do
        expect(subject.map(&:class).uniq).to eql([Game::Move])
      end
    end

    context "on a board with a few moves" do
      let(:board) { Game::Board.new.play(Game::X, 1).play(Game::O, 4).play(Game::X, 8) }

      it { expect(subject.length).to eql(9 - 3) }

      it "returns one Game::Move for each empty space" do
        expected_moves = [
          Game::Move.new(Game::O, 0),
          Game::Move.new(Game::O, 2),
          Game::Move.new(Game::O, 3),
          Game::Move.new(Game::O, 5),
          Game::Move.new(Game::O, 6),
          Game::Move.new(Game::O, 7),
        ]

        is_expected.to contain_exactly(*expected_moves)
      end
    end
  end
end

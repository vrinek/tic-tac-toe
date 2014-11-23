require 'game/progression'
require 'game/board'

describe Game::Progression do
  describe "next moves" do
    subject { Game::Progression.new(board).next_moves }

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

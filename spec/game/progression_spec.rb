require 'game/progression'

describe Game::Progression do
  describe "next moves" do
    subject { Game::Progression.new(board).next_moves }

    context "on an empty board" do
      let(:board) { Game::Board.new }

      it { expect(subject.length).to eql(9) }

      it "returns one Game::Board for each space" do
        expected_strings = [
          '000000001', '000000010', '000000100',
          '000001000', '000010000', '000100000',
          '001000000', '010000000', '100000000',
        ]

        actual_strings = subject.map(&:to_s)

        expect(actual_strings).to contain_exactly(*expected_strings)
      end

      it "returns and Array of Game::Board" do
        expect(subject.map(&:class).uniq).to eql([Game::Board])
      end
    end

    context "on a board with a few moves" do
      let(:board) { Game::Board.new.play(Game::X, 1).play(Game::O, 4).play(Game::X, 8) }

      it { expect(subject.length).to eql(9 - 3) }

      it "returns one Game::Board for each empty space" do
        expected_strings = [
          '010020021', '010020201',
          '010022001', '010220001',
          '012020001', '210020001',
        ]

        actual_strings = subject.map(&:to_s)

        expect(actual_strings).to contain_exactly(*expected_strings)
      end
    end
  end
end

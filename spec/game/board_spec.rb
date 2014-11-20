require 'game/board'

describe Game::Board do
  context "a newly created board" do
    subject { Game::Board.new }

    it { is_expected.to be_empty }
    it { is_expected.to be_valid }
  end

  context "a board with a few of moves" do
    let(:board_str) do
      (Game::EMPTY*9).tap do |str|
        str[3] = Game::X
        str[7] = Game::O
        str[4] = Game::X
      end
    end

    subject { Game::Board.new(board_str) }

    it { is_expected.to_not be_empty }
    it { is_expected.to be_valid }
  end

  context "a board with invalid moves" do
    let(:board_str) do
      (Game::EMPTY*9).tap do |str|
        str[3] = Game::X
        str[7] = Game::X # X plays twice
      end
    end

    subject { Game::Board.new(board_str) }

    it { is_expected.to_not be_valid }
  end
end

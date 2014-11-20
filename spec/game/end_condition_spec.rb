require 'game/end_condition'

describe Game::EndCondition do
  let(:board) { Game::Board.new }
  subject { Game::EndCondition.new(board) }

  context "when no one has played" do
    it { is_expected.to_not be_x_won }
    it { is_expected.to_not be_o_won }
    it { is_expected.to_not be_draw }
  end

  context "when X has aligned horizontally" do
    let(:board) do
      Game::Board.new.
        play(Game::X, 0).play(Game::O, 3).
        play(Game::X, 1).play(Game::O, 5).
        play(Game::X, 2)
    end

    it { is_expected.to be_x_won }
    it { is_expected.to_not be_o_won }
    it { is_expected.to_not be_draw }
  end

  context "when X has aligned vertically" do
    let(:board) do
      Game::Board.new.
        play(Game::X, 1).play(Game::O, 3).
        play(Game::X, 4).play(Game::O, 5).
        play(Game::X, 7)
    end

    it { is_expected.to be_x_won }
    it { is_expected.to_not be_o_won }
    it { is_expected.to_not be_draw }
  end

  context "when X has aligned diagonally" do
    let(:board) do
      Game::Board.new.
        play(Game::X, 0).play(Game::O, 3).
        play(Game::X, 4).play(Game::O, 5).
        play(Game::X, 8)
    end

    it { is_expected.to be_x_won }
    it { is_expected.to_not be_o_won }
    it { is_expected.to_not be_draw }
  end

  context "when O has aligned horizontally" do
    let(:board) do
      Game::Board.new.
        play(Game::X, 6).play(Game::O, 0).
        play(Game::X, 3).play(Game::O, 1).
        play(Game::X, 5).play(Game::O, 2)
    end

    it { is_expected.to be_o_won }
    it { is_expected.to_not be_x_won }
    it { is_expected.to_not be_draw }
  end

  context "when O has aligned vertically" do
    let(:board) do
      Game::Board.new.
        play(Game::X, 6).play(Game::O, 1).
        play(Game::X, 3).play(Game::O, 4).
        play(Game::X, 5).play(Game::O, 7)
    end

    it { is_expected.to be_o_won }
    it { is_expected.to_not be_x_won }
    it { is_expected.to_not be_draw }
  end

  context "when O has aligned diagonally" do
    let(:board) do
      Game::Board.new.
        play(Game::X, 6).play(Game::O, 0).
        play(Game::X, 3).play(Game::O, 4).
        play(Game::X, 5).play(Game::O, 8)
    end

    it { is_expected.to be_o_won }
    it { is_expected.to_not be_x_won }
    it { is_expected.to_not be_draw }
  end

  context "when the board is filled up" do
    let(:board) do
      Game::Board.new.
        play(Game::X, 0).play(Game::O, 1).
        play(Game::X, 3).play(Game::O, 6).
        play(Game::X, 2).play(Game::O, 4).
        play(Game::X, 7).play(Game::O, 8).
        play(Game::X, 5)
    end

    it { is_expected.to be_draw }
    it { is_expected.to_not be_x_won }
    it { is_expected.to_not be_o_won }
  end
end

require 'game/playbook'
require 'game/board'

describe Game::Playbook do
  before(:all) {
    @playbook = Game::Playbook.new
    print "\nPrecompiling the playbook..."
    @playbook.precompile!
    print " Done!\n"
  }

  subject { @playbook }

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

  context "on a board that has been forked" do
    let(:board) { Game::Board.new("022112010") }

    it "calculates the value as MIN" do
      expect(subject.value(board)).to eql(Game::Playbook::MIN)
    end

    it "advices X to just keep playing" do
      expect(subject.best_moves(board)).to contain_exactly(
        Game::Move.new(Game::X, 0),
        Game::Move.new(Game::X, 6),
        Game::Move.new(Game::X, 8)
      )
    end
  end

  context "when precompiling the playbook" do
    before(:all) {
      @board = Game::Board.new("100000002")
      @precompiled_playbook = Game::Playbook.new
      print "\nPrecompiling the playbook..."
      @precompiled_playbook.precompile!
      print " Done!\n"
    }
    let(:precompiled_playbook) { @precompiled_playbook }
    let(:unprecompiled_playbook) { Game::Playbook.new }
    let(:board) { @board }

    it "performs faster" do
      t = Time.now
      precompiled_playbook.value(board)
      precompiled_dt = Time.now - t

      t = Time.now
      unprecompiled_playbook.value(board)
      unprecompiled_dt = Time.now - t

      expect(precompiled_dt < unprecompiled_dt).to be_truthy
    end

    it "returns the same results" do
      precompiled_moves = precompiled_playbook.best_moves(board)
      unprecompiled_moves = unprecompiled_playbook.best_moves(board)

      expect(precompiled_moves).to eql(unprecompiled_moves)
    end
  end
end

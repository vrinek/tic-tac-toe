require 'game/precompiled_playbook'

describe Game::PrecompiledPlaybook do
  before(:all) {
    @board = Game::Board.new("100000002")
    print "\nPrecompiling the playbook..."
    @precompiled_playbook = Game::PrecompiledPlaybook.new
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

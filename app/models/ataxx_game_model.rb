class AtaxxGameModel

  attr_reader :id
  attr_reader :game_state

  def initialize(id)
    @id = id
    @game_state = GameStateModel.new
  end

end

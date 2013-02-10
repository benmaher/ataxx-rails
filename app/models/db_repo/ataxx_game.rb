class AtaxxGame < ActiveRecord::Base

  attr_reader :game_board

  def sync

    prime

    parsed_state = nil
    begin
      parsed_state = JSON.parse(self.state, :symbolize_names => true)
    rescue
    end

    # puts "Parsed state:"
    # puts parsed_state.inspect

    @game_state.load_state(parsed_state)
  end

  def save_state

    self.state = JSON.generate(@game_state.get_state)

    # puts 'Saving state:'
    # puts self.state

    save
  end

  def get_board(board_id)
    @ar_board = AtaxxBoard.find_by_id(board_id)
    if @ar_board == nil
      @game_board = nil
    else
      @game_board = GameGridModel.new
      @game_board.set_size(@ar_board.x_size, @ar_board.y_size)
    end
    return @game_board
  end

  def handle_update(params)
    @game_state.handle_update(params)
    save_state
  end

  def get_state
    @game_state.get_state
  end

  def prime
    if !@primed
      @primed = true
      @game_state = GameStateModel.new
      @game_board = get_board(self.board_id)
      @game_state.attach_board(@game_board)
    end
  end

  def setup(data)

    # puts 'Setup data:'
    # puts data.inspect

    self.board_id = data[:board_id]

    prime

    self.moves = '[]'

    @game_state.setup(data)
    save_state

    # puts 'Game row inpsection:'
    # puts inspect



  end

end

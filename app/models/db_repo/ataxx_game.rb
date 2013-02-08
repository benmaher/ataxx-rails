class AtaxxGame < ActiveRecord::Base

  attr_reader :game_board

  def sync
    # verify_components

    # puts '##############'
    # puts @game_board.inspect
    # puts '##############'

    parsed_state = nil
    begin
      parsed_state = JSON.parse(self.state, :symbolize_names => true)
    rescue
    end

    puts '##############'
    puts parsed_state.inspect
    puts '##############'

    @game_state.load_state(parsed_state)
  end

  def save_state
    self.state = JSON.generate(@game_state.get_state)
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
  end

  def get_state
    @game_state.get_state
  end

  def setup(data)
    puts "========\n" + self.class.name + "##{__method__}" + "\n========\n"

    @setup_occurred = true

    # puts data.inspect
    self.board_id = data[:board_id]

    @game_state = GameStateModel.new
    @game_board = get_board(self.board_id)
    @game_state.attach_board(@game_board)


    puts 'self'
    puts inspect

    puts 'data'
    puts data.inspect

    @game_state.setup(data)

    hold_state = @game_state.get_state

    puts 'game state'
    puts hold_state.inspect

    self.state = JSON.generate(hold_state)

    puts 'JSON game state'
    puts self.state.inspect


    puts 'self'
    puts inspect


    self.moves = '[]'
    save

    puts "========\n" + self.class.name + "##{__method__}" + "\n========\n"

  end

end

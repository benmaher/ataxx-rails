class AtaxxController < ApplicationController


  def index

  end

  def new
    @game = create_new_game
    @game_id = @game.id

    puts "NEW GAME ID: #{@game_id}"

    redirect_to game_url(@game_id)
  end

  def game
    @game = get_game(params[:id])

    if @game == nil
      @game = create_new_game
    end

    @game_id = @game.id

    @game.sync
    @board = @game.game_board
  end

  def get_game(game_id)
    return AtaxxGame.find_by_id(game_id)
  end

  def create_new_game()
    # game_id = SecureRandom.uuid
    game = AtaxxGame.new
    game.setup({
      :board_id => 2,
      :players => [
        {
          name: 'Uno',
          initial_locations: ['a7', 'g1']
        },
        {
          name: 'Dos',
          initial_locations: ['a1', 'g7']
        }
      ]
      })
    return game
  end

  # def start
  #   @game = create_new_game()
  #   @game_id = @game.id
  #   redirect_to "/ataxx/update"
  # end

  def update
    @game_id = params[:id]
    @game = get_game(@game_id)
    puts "Checking game #{@game_id}"
    if @game != nil
      puts "Found game #{@game_id}"
      puts "Synching game"
      @game.sync
      puts "Updating game"
      @game.handle_update(params)
      state = @game.get_state
      respond_to do |format|
        format.html { render :text => "hi there" }
        format.js { render :json => {
          # :debug => params.inspect,
          :debug => state.inspect,
          # :state => @game.game_state.get_state_stats
          :state => state
          }}
      end
    end
  end

  def test
    @@count += 1
    respond_to do |format|
      format.js { render :json => {:title => @@count}}
    end
  end



end

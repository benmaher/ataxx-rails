class AtaxxController < ApplicationController

  @@game_count = 0
  @@games = {}


  def index
    # if params[:new_game]
    #   game = AtaxxGameModel.new
    #   @@game[game_id]
    # end


    # respond_to do |format|
    #   format.html { render 'index' }
    #   format.js { render :json => {:title => "fine"}}
    # end

    @@games = {}
    @game_id = params[:game_id]
    @game = get_game(@game_id)
    if @game == nil
      @game = create_new_game
      @game_id = @game.id
    end

    @game_grid = @game.game_state.game_grid_model

    puts "================"
    puts @game_id
    puts "================"
  end

  def get_game(game_id)
    @@games[game_id]
  end

  def create_new_game()
    game_id = SecureRandom.uuid
    game = AtaxxGameModel.new(game_id)
    @@games[game_id] = game
    game.game_state.start
    return game
  end

  # def start
  #   @game = create_new_game()
  #   @game_id = @game.id
  #   redirect_to "/ataxx/update"
  # end

  def update
    @game_id = params[:game_id]
    @game = get_game(@game_id)
    puts "checking game #{@game_id}"
    if @game != nil
      puts "found game #{@game_id}"
      state = @game.game_state.handle_update(params)
      respond_to do |format|
        format.html { render :text => "hi there" }
        format.js { render :json => {
          # :debug => params.inspect,
          :debug => @game.game_state.get_state_stats.inspect,
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

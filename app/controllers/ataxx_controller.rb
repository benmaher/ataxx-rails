class AtaxxController < ApplicationController

  @@game_count = 0


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
    return game
  end

  def update
    @game_id = params[:game_id]
    @game = get_game(@game_id)
    if @game != nil
       respond_to do |format|
        format.js { render :json => {:debug => params.inspect}}
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

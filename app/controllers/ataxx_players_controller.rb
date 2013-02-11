class AtaxxPlayersController < ApplicationController
  # GET /ataxx_players
  # GET /ataxx_players.json
  def index
    @ataxx_players = AtaxxPlayer.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ataxx_players }
    end
  end

  # GET /ataxx_players/1
  # GET /ataxx_players/1.json
  def show
    @ataxx_player = AtaxxPlayer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ataxx_player }
    end
  end

  # GET /ataxx_players/new
  # GET /ataxx_players/new.json
  def new
    @ataxx_player = AtaxxPlayer.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ataxx_player }
    end
  end

  # GET /ataxx_players/1/edit
  def edit
    @ataxx_player = AtaxxPlayer.find(params[:id])
  end

  # POST /ataxx_players
  # POST /ataxx_players.json
  def create
    @ataxx_player = AtaxxPlayer.new(params[:ataxx_player])

    respond_to do |format|
      if @ataxx_player.save
        format.html { redirect_to @ataxx_player, notice: 'Ataxx player was successfully created.' }
        format.json { render json: @ataxx_player, status: :created, location: @ataxx_player }
      else
        format.html { render action: "new" }
        format.json { render json: @ataxx_player.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /ataxx_players/1
  # PUT /ataxx_players/1.json
  def update
    @ataxx_player = AtaxxPlayer.find(params[:id])

    respond_to do |format|
      if @ataxx_player.update_attributes(params[:ataxx_player])
        format.html { redirect_to @ataxx_player, notice: 'Ataxx player was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @ataxx_player.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ataxx_players/1
  # DELETE /ataxx_players/1.json
  def destroy
    @ataxx_player = AtaxxPlayer.find(params[:id])
    @ataxx_player.destroy

    respond_to do |format|
      format.html { redirect_to ataxx_players_url }
      format.json { head :no_content }
    end
  end
end

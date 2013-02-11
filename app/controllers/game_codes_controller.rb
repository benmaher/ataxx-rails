class GameCodesController < ApplicationController
  # GET /game_codes
  # GET /game_codes.json
  def index
    @game_codes = GameCode.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @game_codes }
    end
  end

  # GET /game_codes/1
  # GET /game_codes/1.json
  def show
    @game_code = GameCode.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @game_code }
    end
  end

  # GET /game_codes/new
  # GET /game_codes/new.json
  def new
    @game_code = GameCode.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @game_code }
    end
  end

  # GET /game_codes/1/edit
  def edit
    @game_code = GameCode.find(params[:id])
  end

  # POST /game_codes
  # POST /game_codes.json
  def create
    @game_code = GameCode.new(params[:game_code])

    respond_to do |format|
      if @game_code.save
        format.html { redirect_to @game_code, notice: 'Game code was successfully created.' }
        format.json { render json: @game_code, status: :created, location: @game_code }
      else
        format.html { render action: "new" }
        format.json { render json: @game_code.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /game_codes/1
  # PUT /game_codes/1.json
  def update
    @game_code = GameCode.find(params[:id])

    respond_to do |format|
      if @game_code.update_attributes(params[:game_code])
        format.html { redirect_to @game_code, notice: 'Game code was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @game_code.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /game_codes/1
  # DELETE /game_codes/1.json
  def destroy
    @game_code = GameCode.find(params[:id])
    @game_code.destroy

    respond_to do |format|
      format.html { redirect_to game_codes_url }
      format.json { head :no_content }
    end
  end
end

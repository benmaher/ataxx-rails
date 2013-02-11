class AtaxxBoardsController < ApplicationController
  # GET /ataxx_boards
  # GET /ataxx_boards.json
  def index
    @ataxx_boards = AtaxxBoard.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ataxx_boards }
    end
  end

  # GET /ataxx_boards/1
  # GET /ataxx_boards/1.json
  def show
    @ataxx_board = AtaxxBoard.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ataxx_board }
    end
  end

  # GET /ataxx_boards/new
  # GET /ataxx_boards/new.json
  def new
    @ataxx_board = AtaxxBoard.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ataxx_board }
    end
  end

  # GET /ataxx_boards/1/edit
  def edit
    @ataxx_board = AtaxxBoard.find(params[:id])
  end

  # POST /ataxx_boards
  # POST /ataxx_boards.json
  def create
    @ataxx_board = AtaxxBoard.new(params[:ataxx_board])

    respond_to do |format|
      if @ataxx_board.save
        format.html { redirect_to @ataxx_board, notice: 'Ataxx board was successfully created.' }
        format.json { render json: @ataxx_board, status: :created, location: @ataxx_board }
      else
        format.html { render action: "new" }
        format.json { render json: @ataxx_board.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /ataxx_boards/1
  # PUT /ataxx_boards/1.json
  def update
    @ataxx_board = AtaxxBoard.find(params[:id])

    respond_to do |format|
      if @ataxx_board.update_attributes(params[:ataxx_board])
        format.html { redirect_to @ataxx_board, notice: 'Ataxx board was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @ataxx_board.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ataxx_boards/1
  # DELETE /ataxx_boards/1.json
  def destroy
    @ataxx_board = AtaxxBoard.find(params[:id])
    @ataxx_board.destroy

    respond_to do |format|
      format.html { redirect_to ataxx_boards_url }
      format.json { head :no_content }
    end
  end
end

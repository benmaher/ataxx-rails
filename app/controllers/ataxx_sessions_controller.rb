class AtaxxSessionsController < ApplicationController
  # GET /ataxx_sessions
  # GET /ataxx_sessions.json
  def index
    @ataxx_sessions = AtaxxSession.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ataxx_sessions }
    end
  end

  # GET /ataxx_sessions/1
  # GET /ataxx_sessions/1.json
  def show
    @ataxx_session = AtaxxSession.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ataxx_session }
    end
  end

  # GET /ataxx_sessions/new
  # GET /ataxx_sessions/new.json
  def new
    @ataxx_session = AtaxxSession.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ataxx_session }
    end
  end

  # GET /ataxx_sessions/1/edit
  def edit
    @ataxx_session = AtaxxSession.find(params[:id])
  end

  # POST /ataxx_sessions
  # POST /ataxx_sessions.json
  def create
    @ataxx_session = AtaxxSession.new(params[:ataxx_session])

    respond_to do |format|
      if @ataxx_session.save
        format.html { redirect_to @ataxx_session, notice: 'Ataxx session was successfully created.' }
        format.json { render json: @ataxx_session, status: :created, location: @ataxx_session }
      else
        format.html { render action: "new" }
        format.json { render json: @ataxx_session.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /ataxx_sessions/1
  # PUT /ataxx_sessions/1.json
  def update
    @ataxx_session = AtaxxSession.find(params[:id])

    respond_to do |format|
      if @ataxx_session.update_attributes(params[:ataxx_session])
        format.html { redirect_to @ataxx_session, notice: 'Ataxx session was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @ataxx_session.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ataxx_sessions/1
  # DELETE /ataxx_sessions/1.json
  def destroy
    @ataxx_session = AtaxxSession.find(params[:id])
    @ataxx_session.destroy

    respond_to do |format|
      format.html { redirect_to ataxx_sessions_url }
      format.json { head :no_content }
    end
  end
end

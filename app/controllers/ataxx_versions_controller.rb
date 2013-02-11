class AtaxxVersionsController < ApplicationController
  # GET /ataxx_versions
  # GET /ataxx_versions.json
  def index
    @ataxx_versions = AtaxxVersion.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ataxx_versions }
    end
  end

  # GET /ataxx_versions/1
  # GET /ataxx_versions/1.json
  def show
    @ataxx_version = AtaxxVersion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ataxx_version }
    end
  end

  # GET /ataxx_versions/new
  # GET /ataxx_versions/new.json
  def new
    @ataxx_version = AtaxxVersion.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ataxx_version }
    end
  end

  # GET /ataxx_versions/1/edit
  def edit
    @ataxx_version = AtaxxVersion.find(params[:id])
  end

  # POST /ataxx_versions
  # POST /ataxx_versions.json
  def create
    @ataxx_version = AtaxxVersion.new(params[:ataxx_version])

    respond_to do |format|
      if @ataxx_version.save
        format.html { redirect_to @ataxx_version, notice: 'Ataxx version was successfully created.' }
        format.json { render json: @ataxx_version, status: :created, location: @ataxx_version }
      else
        format.html { render action: "new" }
        format.json { render json: @ataxx_version.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /ataxx_versions/1
  # PUT /ataxx_versions/1.json
  def update
    @ataxx_version = AtaxxVersion.find(params[:id])

    respond_to do |format|
      if @ataxx_version.update_attributes(params[:ataxx_version])
        format.html { redirect_to @ataxx_version, notice: 'Ataxx version was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @ataxx_version.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ataxx_versions/1
  # DELETE /ataxx_versions/1.json
  def destroy
    @ataxx_version = AtaxxVersion.find(params[:id])
    @ataxx_version.destroy

    respond_to do |format|
      format.html { redirect_to ataxx_versions_url }
      format.json { head :no_content }
    end
  end
end

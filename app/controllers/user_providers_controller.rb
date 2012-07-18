class UserProvidersController < ApplicationController
  # GET /user_providers
  # GET /user_providers.json
  def index
    @user_providers = UserProvider.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @user_providers }
    end
  end

  # GET /user_providers/1
  # GET /user_providers/1.json
  def show
    @user_provider = UserProvider.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user_provider }
    end
  end

  # GET /user_providers/new
  # GET /user_providers/new.json
  def new
    @user_provider = UserProvider.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user_provider }
    end
  end

  # GET /user_providers/1/edit
  def edit
    @user_provider = UserProvider.find(params[:id])
  end

  # POST /user_providers
  # POST /user_providers.json
  def create
    @user_provider = UserProvider.new(params[:user_provider])

    respond_to do |format|
      if @user_provider.save
        format.html { redirect_to @user_provider, notice: 'User provider was successfully created.' }
        format.json { render json: @user_provider, status: :created, location: @user_provider }
      else
        format.html { render action: "new" }
        format.json { render json: @user_provider.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /user_providers/1
  # PUT /user_providers/1.json
  def update
    @user_provider = UserProvider.find(params[:id])

    respond_to do |format|
      if @user_provider.update_attributes(params[:user_provider])
        format.html { redirect_to @user_provider, notice: 'User provider was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user_provider.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_providers/1
  # DELETE /user_providers/1.json
  def destroy
    @user_provider = UserProvider.find(params[:id])
    @user_provider.destroy

    respond_to do |format|
      format.html { redirect_to user_providers_url }
      format.json { head :no_content }
    end
  end
end

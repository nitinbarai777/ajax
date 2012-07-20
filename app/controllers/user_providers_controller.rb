class UserProvidersController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_filter :require_admin, :only => [:index]
  
  def index
    @users = UserProvider.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 10, :page => params[:page])
  end
  
  def show
    @user = UserProvider.find(params[:id])
  end

  def destroy
    @user = UserProvider.find(params[:id])
    @user.destroy
    flash[:notice] = "Successfully destroyed User."
    redirect_to user_providers_url
  end


  private
  
  def sort_column
    UserProvider.column_names.include?(params[:sort]) ? params[:sort] : "id"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end

end

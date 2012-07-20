class MerchantLocationsController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_filter :require_admin

  # fetch all records
  def index
	unless params[:id].nil?
		session[:merchant_id] = params[:id].to_i
	end
    @o_all = MerchantLocation.search(params[:search], session[:merchant_id]).order(sort_column + " " + sort_direction).paginate(:per_page => 10, :page => params[:page])
  end
  
  #fetch single record and display
  def show
    @o_single = MerchantLocation.find(params[:id])
  end
  
  # generate a form for new record
  def new
    @o_single = MerchantLocation.new
  end
  
  #create a new record and save in database
  def create
    @o_single = MerchantLocation.new(params[:merchant_location])
    if @o_single.save
      flash[:notice] = t("general.successfully_created")
      redirect_to merchant_locations_path
    else
      render :action => 'new'
    end
  end
  
  # generate a edit form to update the record
  def edit
    @o_single = MerchantLocation.find(params[:id])
	@o_all_area = Area.where(:city_id => @o_single.city_id)
  end
  
  # update a record and save in database
  def update
    @o_single = MerchantLocation.find(params[:id])
    if @o_single.update_attributes(params[:merchant_location])
      flash[:notice] = t("general.successfully_updated")
      redirect_to merchant_locations_path
    else
      render :action => 'edit'
    end
  end
  
  #destoy a record
  def destroy
    @o_single = MerchantLocation.find(params[:id])
    @o_single.destroy
    flash[:notice] = t("general.successfully_destroyed")
    redirect_to merchant_locations_url
  end
  def list_area_by_city
	@o_area = Area.where(:city_id => params[:id])
  end
  private
  
  # sort column private method
  def sort_column
    MerchantLocation.column_names.include?(params[:sort]) ? params[:sort] : "id"
  end
  
  # order records private method
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end
end

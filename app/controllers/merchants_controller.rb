class MerchantsController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_filter :require_admin

  # fetch all records
  def index
    @o_all = Merchant.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 10, :page => params[:page])
  end
  
  #fetch single record and display
  def show
    @o_single = Merchant.find(params[:id])
  end
  
  # generate a form for new record
  def new
    @o_single = Merchant.new
  end
  
  #create a new record and save in database
  def create
    @o_single = Merchant.new(params[:merchant])
    if @o_single.save
      flash[:notice] = t("general.successfully_created")
      redirect_to merchants_path
    else
      render :action => 'new'
    end
  end
  
  # generate a edit form to update the record
  def edit
    @o_single = Merchant.find(params[:id])
  end
  
  # update a record and save in database
  def update
    @o_single = Merchant.find(params[:id])
    if @o_single.update_attributes(params[:merchant])
      flash[:notice] = t("general.successfully_updated")
      redirect_to merchants_path
    else
      render :action => 'edit'
    end
  end
  
  #destoy a record
  def destroy
    @o_single = Merchant.find(params[:id])
    @o_single.destroy
    flash[:notice] = t("general.successfully_destroyed")
    redirect_to merchants_url
  end
  
  private
  
  # sort column private method
  def sort_column
    Merchant.column_names.include?(params[:sort]) ? params[:sort] : "id"
  end
  
  # order records private method
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end
end

class CoupontypesController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_filter :require_admin

  # fetch all records
  def index
    @o_all = Coupontype.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 10, :page => params[:page])
  end
  
  #fetch single record and display
  def show
    @o_single = Coupontype.find(params[:id])
  end
  
  # generate a form for new record
  def new
    @o_single = Coupontype.new
  end
  
  #create a new record and save in database
  def create
    @o_single = Coupontype.new(params[:coupontype])
    if @o_single.save
      flash[:notice] = t("general.successfully_created")
      redirect_to coupontypes_path
    else
      render :action => 'new'
    end
  end
  
  # generate a edit form to update the record
  def edit
    @o_single = Coupontype.find(params[:id])
  end
  
  # update a record and save in database
  def update
    @o_single = Coupontype.find(params[:id])
    if @o_single.update_attributes(params[:coupontype])
      flash[:notice] = t("general.successfully_updated")
      redirect_to coupontypes_path
    else
      render :action => 'edit'
    end
  end
  
  #destoy a record
  def destroy
    @o_single = Coupontype.find(params[:id])
    @o_single.destroy
    flash[:notice] = t("general.successfully_destroyed")
    redirect_to coupontypes_url
  end
  
  private
  
  # sort column private method
  def sort_column
    Coupontype.column_names.include?(params[:sort]) ? params[:sort] : "id"
  end
  
  # order records private method
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end
end

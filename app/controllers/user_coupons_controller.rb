class UserCouponsController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_filter :require_user
  #before_filter :require_admin

  # fetch all records
  def index
    @o_all = UserCoupon.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 10, :page => params[:page])
  end
  
  #fetch single record and display
  def show
    @o_single = UserCoupon.find(params[:id])
  end
  
  #destoy a record
  def destroy
    @o_single = UserCoupon.find(params[:id])
    @o_single.destroy
    flash[:notice] = t("general.successfully_destroyed")
    redirect_to user_coupons_url
  end
  
  private
  
  # sort column private method
  def sort_column
    UserCoupon.column_names.include?(params[:sort]) ? params[:sort] : "id"
  end
  
  # order records private method
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end
end

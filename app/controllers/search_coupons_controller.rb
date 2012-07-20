class SearchCouponsController < ApplicationController
  layout "fronts"
  helper_method :sort_column, :sort_direction
  # search merchant
  def index
    @o_all = Merchant.get_search_coupons(params[:merchant_id], params[:city_id], params[:area_id]).order(sort_column + " " + sort_direction).paginate(:per_page => 10, :page => params[:page])
  end
  def list_area_by_city
	@o_area = Area.where(:city_id => params[:id])
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

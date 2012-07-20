class Merchant < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  attr_accessible :email, :image, :name, :url
  has_many :merchant_location, :dependent => :destroy


  def self.search(search)
    if search
      where('name LIKE ? OR email LIKE ? OR url LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%")
    else
      scoped
    end
  end

  def self.get_search_coupons(merchant_id, city_id, area_id)

	if !merchant_id && !city_id && !area_id
	  joins(:merchant_location => [:city, :area, :coupon]).select("merchants.id, merchants.name, merchants.email, merchants.url, merchant_locations.city_id, merchant_locations.area_id, merchant_locations.contact, cities.name as cityname, areas.name as areaname, coupons.name as couponname, coupons.price, coupons.valid_to")
	else
		if merchant_id != "" && city_id != "" && area_id != ""
		  joins(:merchant_location => [:city, :area, :coupon]).where("merchants.id" => merchant_id, "merchant_locations.city_id" => city_id, "merchant_locations.area_id" => area_id).select("merchants.id, merchants.name, merchants.email, merchants.url, merchant_locations.city_id, merchant_locations.area_id, merchant_locations.contact, cities.name as cityname, areas.name as areaname, coupons.name as couponname, coupons.price, coupons.valid_to")
		elsif merchant_id != "" && city_id != ""
		  joins(:merchant_location => [:city, :area, :coupon]).where("merchants.id" => merchant_id, "merchant_locations.city_id" => city_id).select("merchants.id, merchants.name, merchants.email, merchants.url, merchant_locations.city_id, merchant_locations.area_id, merchant_locations.contact, cities.name as cityname, areas.name as areaname, coupons.name as couponname, coupons.price, coupons.valid_to")
		elsif merchant_id != "" && area_id != ""
		  joins(:merchant_location => [:city, :area, :coupon]).where("merchants.id" => merchant_id, "merchant_locations.area_id" => area_id).select("merchants.id, merchants.name, merchants.email, merchants.url, merchant_locations.city_id, merchant_locations.area_id, merchant_locations.contact, cities.name as cityname, areas.name as areaname, coupons.name as couponname, coupons.price, coupons.valid_to")
		elsif city_id != "" && area_id != ""
		  joins(:merchant_location => [:city, :area, :coupon]).where("merchant_locations.city_id" => city_id, "merchant_locations.area_id" => area_id).select("merchants.id, merchants.name, merchants.email, merchants.url, merchant_locations.city_id, merchant_locations.area_id, merchant_locations.contact, cities.name as cityname, areas.name as areaname, coupons.name as couponname, coupons.price, coupons.valid_to")
		elsif merchant_id != ""
		  joins(:merchant_location => [:city, :area, :coupon]).where("merchants.id" => merchant_id).select("merchants.id, merchants.name, merchants.email, merchants.url, merchant_locations.city_id, merchant_locations.area_id, merchant_locations.contact, cities.name as cityname, areas.name as areaname, coupons.name as couponname, coupons.price, coupons.valid_to")
		elsif city_id != ""
		  joins(:merchant_location => [:city, :area, :coupon]).where("merchant_locations.city_id" => city_id).select("merchants.id, merchants.name, merchants.email, merchants.url, merchant_locations.city_id, merchant_locations.area_id, merchant_locations.contact, cities.name as cityname, areas.name as areaname, coupons.name as couponname, coupons.price, coupons.valid_to")
		elsif area_id != ""
		  joins(:merchant_location => [:city, :area, :coupon]).where("merchant_locations.area_id" => area_id).select("merchants.id, merchants.name, merchants.email, merchants.url, merchant_locations.city_id, merchant_locations.area_id, merchant_locations.contact, cities.name as cityname, areas.name as areaname, coupons.name as couponname, coupons.price, coupons.valid_to")
		else
		  joins(:merchant_location => [:city, :area, :coupon]).select("merchants.id, merchants.name, merchants.email, merchants.url, merchant_locations.city_id, merchant_locations.area_id, merchant_locations.contact, cities.name as cityname, areas.name as areaname, coupons.name as couponname, coupons.price, coupons.valid_to")
		end
	end

  end

end

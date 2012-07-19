class Coupon < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  belongs_to :coupontype
  belongs_to :merchant_location
  has_many :user_coupons, :dependent => :destroy
  attr_accessible :address, :description, :free_coupon, :highlights, :image, :is_active, :min_purchase, :name, :offer, :price, :term_conditions, :up_comming, :coupontype_id, :merchant_location_id, :valid_from, :valid_to
  def self.search(search, id)
    if search
      where('name LIKE ?', "%#{search}%")
    elsif !id.nil?
   	  where(:merchant_location_id => id)
	else
      scoped
    end
  end

  def self.search_filterby_city(id)
    if !id.nil?
	  #joins('LEFT OUTER JOIN merchant_locations ON merchant_locations.id = coupons.merchant_location_id')
   	  joins(:merchant_location).where("merchant_locations.city_id" => id)
	else
      scoped
    end
  end

  def self.search_filterby_area(id)
    if !id.nil?
   	  joins(:merchant_location).where("merchant_locations.area_id" => id)
	else
      scoped
    end
  end

end

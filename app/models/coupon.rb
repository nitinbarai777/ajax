class Coupon < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  belongs_to :coupontype
  belongs_to :merchant_location
  attr_accessible :address, :description, :free_coupon, :highlights, :image, :is_active, :min_purchase, :name, :offer, :price, :term_conditions, :up_comming, :coupontype_id, :merchant_location_id
  def self.search(search, id)
    if search
      where('name LIKE ?', "%#{search}%")
    elsif !id.nil?
   	  where(:merchant_location_id => id)
	else
      scoped
    end
  end
end

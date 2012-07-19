class MerchantLocation < ActiveRecord::Base
  belongs_to :city
  belongs_to :area
  belongs_to :merchant
  belongs_to :category
  has_many :coupon, :dependent => :destroy
  attr_accessible :address, :contact, :contact_person, :email, :latitude, :longitude, :city_id, :area_id, :category_id, :merchant_id
  validates :city, :area, :presence => true
  def self.search(search, id)
    if search
      where('contact_person LIKE ?', "%#{search}%")
    elsif !id.nil?
   	  where(:merchant_id => id)
	else
      scoped
    end
  end
end

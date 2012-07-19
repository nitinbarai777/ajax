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
end

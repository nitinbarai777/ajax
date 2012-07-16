class User < ActiveRecord::Base
  acts_as_authentic
  mount_uploader :image, ImageUploader
  attr_accessible :crypted_password, :email, :password_salt, :persistence_token, :username, :password, :password_confirmation, :address, :city, :state, :zipcode, :contact, :is_admin, :image, :first_name, :last_name, :carrier_id, :mobile_number, :gateway_id, :is_active
  belongs_to :carrier
  belongs_to :gateway
  
  validates :first_name, :last_name, :mobile_number, :presence => true
  #validates :description, :presence => true, :length => { :minimum => 10 }

  def self.search(search)
    if search
      where('((username LIKE ? OR email LIKE ? OR mobile_number LIKE ?) AND is_admin != ?)', "%#{search}%", "%#{search}%", "%#{search}%", 1)
    else
      where('is_admin != ?', 1)
    end
  end
end

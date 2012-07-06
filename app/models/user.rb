class User < ActiveRecord::Base
  acts_as_authentic
  mount_uploader :image, ImageUploader
  attr_accessible :crypted_password, :email, :password_salt, :persistence_token, :username, :password, :password_confirmation, :address, :city, :state, :zipcode, :contact, :is_admin, :image, :remote_image_url, :income

  def self.search(search)
    if search
      where('username LIKE ? OR email LIKE ?', "%#{search}%", "%#{search}%")
    else
      scoped
    end
  end

end

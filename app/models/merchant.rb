class Merchant < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  attr_accessible :email, :image, :name, :url


  def self.search(search)
    if search
      where('name LIKE ?', "%#{search}%")
    else
      scoped
    end
  end
end

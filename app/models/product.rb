class Product < ActiveRecord::Base
  attr_accessible :name, :price, :released_at
  
  def self.search(search)
    if search
      where('name LIKE ? OR price LIKE ?', "%#{search}%", "%#{search}%")
    else
      scoped
    end
  end
end
